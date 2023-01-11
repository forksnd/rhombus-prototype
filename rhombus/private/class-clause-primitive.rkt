#lang racket/base
(require (for-syntax racket/base
                     syntax/parse/pre
                     enforest/hier-name-parse
                     "name-path-op.rkt"
                     "class-parse.rkt"
                     (only-in "rule.rkt" rule)
                     "consistent.rkt")
         "class+interface.rkt"
         "class-clause.rkt"
         (only-in "annotation.rkt" :: -:)
         (submod "annotation.rkt" for-class)
         "parens.rkt"
         "name-root-ref.rkt"
         "var-decl.rkt"
         (only-in "assign.rkt" :=)
         (only-in "function.rkt" fun)
         (submod "function.rkt" for-method)
         (only-in "implicit.rkt" #%body))

(provide (for-syntax wrap-class-clause)
         rhombus-class
         extends
         implements
         internal
         constructor
         expression
         binding
         annotation
         final
         nonfinal
         authentic
         field
         method
         property
         override
         private
         abstract

         final-override
         final-property
         final-override-property
         abstract-property
         abstract-override
         abstract-override-property
         private-implements
         private-override
         private-property
         private-override-property
         override-property)


(define-syntax rhombus-class 'placeholder)

(define-for-syntax (wrap-class-clause parsed)
  #`[(group (parsed (quote-syntax (rhombus-class #,parsed) #:local)))]) ; `quote-syntax` + `rhombus-class` wrapper => clause

(define-for-syntax (parse-multiple-names stx)
  (define lines
    (syntax-parse stx
      [(_ (tag::block (group form ...) ...))
       (syntax->list #'((form ...) ...))]
      [(_ form ...)
       (list #'(form ...))]))
  (apply append
         (for/list ([line (in-list lines)])
           (let loop ([line line])
             (syntax-parse line
               [() null]
               [(~var id (:hier-name-seq in-class-desc-space name-path-op name-root-ref))
                (cons #'id.name (loop #'id.tail))])))))

(define-syntax extends
  (make-class+interface-clause-transformer
   ;; class clause
   (lambda (stx data)
     (syntax-parse stx
       [(_ (~seq form ...))
        #:with (~var id (:hier-name-seq in-class-desc-space name-path-op name-root-ref)) #'(form ...)
        #:with () #'id.tail
        (wrap-class-clause #'(extends id.name))]))
   ;; interface clause
   (lambda (stx data)
     (define names (parse-multiple-names stx))
     (wrap-class-clause #`(extends . #,names)))))

(define-syntax implements
  (class-clause-transformer
   (lambda (stx data)
     (define names (parse-multiple-names stx))
     (wrap-class-clause #`(implements . #,names)))))

(define-syntax internal
  (make-class+interface-clause-transformer
   (lambda (stx data)
     (syntax-parse stx
       [(_ name:identifier)
        (wrap-class-clause #'(internal name))]))))

(define-for-syntax (make-macro-clause-transformer
                    key
                    #:clause-transformer [clause-transformer make-class+interface-clause-transformer])
  (clause-transformer
   (lambda (stx data)
     (syntax-parse stx
       #:datum-literals (group)
       [(form-name (~and (_::quotes . _)
                         pattern)
                   (~and (_::block . _)
                         template-block))
        (wrap-class-clause #`(#,key (block (named-rule rule #,stx pattern template-block))))]
       [(form-name (~and rhs (_::alts
                              (_::block (group (_::quotes . _)
                                               (_::block . _)))
                              ...)))
        (wrap-class-clause #`(#,key (block (named-rule rule #,stx rhs))))]
       [(form-name (~and (_::block . _)
                         a-block))
        (wrap-class-clause #`(#,key a-block))]))))

(define-syntax binding
  (make-macro-clause-transformer #'binding
                                 #:clause-transformer class-clause-transformer))

(define-syntax annotation
  (make-macro-clause-transformer #'annotation))

(define-syntax nonfinal
  (class-clause-transformer
   (lambda (stx data)
     (syntax-parse stx
       [(_) (wrap-class-clause #`(nonfinal))]))))

(define-syntax authentic
  (class-clause-transformer
   (lambda (stx data)
     (syntax-parse stx
       [(_) (wrap-class-clause #`(authentic))]))))

(begin-for-syntax
  (define-splicing-syntax-class (:field mode)
    #:description "field identifier with optional annotation"
    #:attributes (form)
    (pattern (~seq form-id d::var-decl)
             #:with (id:identifier (~optional c::unparsed-inline-annotation)) #'(d.bind ...)
             #:attr ann-seq (if (attribute c)
                                #'c.seq
                                #'#f)
             #:attr form (wrap-class-clause #`(field id
                                                     tmp-id ann-seq d.blk form-id
                                                     #,mode)))))

(define-syntax field
  (class-clause-transformer
   (lambda (stx data)
     (syntax-parse stx
       [((~var f (:field 'public)))
        #'f.form]))))

(define-syntax-rule (if/blocked tst thn els)
  (if tst (let () thn) els))

(begin-for-syntax
  (define-splicing-syntax-class :maybe-ret
    #:attributes (seq)
    #:literals (:: -:)
    #:datum-literals (op)
    (pattern (~seq (~and o (op (~or :: -:))) ret ...)
             #:attr seq #'(o ret ...))
    (pattern (~seq)
             #:attr seq #'()))
  (define-splicing-syntax-class (:method mode)
    #:description "method implementation"
    #:attributes (form)
    #:datum-literals (group)
    (pattern (~seq id:identifier (~and args (_::parens . _)) ret::maybe-ret
                   (~and rhs (_::block . _)))
             #:attr form (wrap-class-clause #`(#,mode id
                                               (block (group fun args rhs))
                                               ret.seq)))
    (pattern (~seq (~and alts
                         (atag::alts
                          (btag::block ((~and gtag group) a-id:identifier
                                                          (~and args (_::parens . _)) ret::maybe-ret
                                                          (~and body (_::block . _))))
                          ...+)))
             #:do [(define a-ids (syntax->list #'(a-id ...)))
                   (check-consistent #:who (syntax-e mode) #'alts a-ids "name")]
             #:attr id (car a-ids)
             #:with (ret0 ...) (let ([retss (syntax->list #'(ret.seq ...))])
                                 (if (for/and ([rets (in-list (cdr retss))])
                                       (same-return-signature? (car retss) rets))
                                     (car retss)
                                     '()))
             #:attr form (wrap-class-clause #`(#,mode id
                                               (block (group fun (atag (btag (gtag args body)) ...)))
                                               (ret0 ...))))
    (pattern (~seq id:identifier ret::maybe-ret (~and rhs (_::block . _)))
             #:attr form (wrap-class-clause #`(#,mode id rhs ret.seq))))
  (define-splicing-syntax-class :method-decl
    #:description "method declaration"
    #:attributes (id rhs maybe-ret)
    (pattern (~seq id:identifier (tag::parens arg ...) ret::maybe-ret)
             #:attr rhs #'(block (group fun (tag arg ...)
                                        (block (group (parsed (void))))))
             #:attr maybe-ret #'ret.seq)
    (pattern (~seq id:identifier ret::maybe-ret)
             #:attr rhs #'#f
             #:attr maybe-ret #'ret.seq))
  (define-splicing-syntax-class (:property mode)
    #:description "property implementation"
    #:attributes (form)
    #:datum-literals (group op)
    #:literals (:=)
    (pattern (~seq id:identifier ret::maybe-ret
                   (~and rhs (_::block . _)))
             #:attr form (wrap-class-clause #`(#,mode id
                                               (block
                                                (group fun/read-only-property
                                                       (alts
                                                        (block (group (parens) rhs))
                                                        (block (group (parens (group ignored))
                                                                      (block (group (parsed (not-assignable 'id)))))))))
                                               ret.seq)))
    
    (pattern (~seq (_::alts
                    (_::block
                     (group id:identifier ret::maybe-ret
                            (~and rhs (_::block . _))))))
             #:attr form (wrap-class-clause #`(#,mode id
                                               (block
                                                (group fun/read-only-property
                                                       (alts
                                                        (block (group (parens) rhs))
                                                        (block (group (parens (group ignored))
                                                                      (block (group (parsed (not-assignable 'id)))))))))
                                               ret.seq)))
    (pattern (~seq (~and alts
                         (atag::alts
                          (btag1::block
                           ((~and gtag1 group) a-id1:identifier ret1::maybe-ret
                                               (~and body1 (_::block . _))))
                          (btag2::block
                           ((~and gtag2 group) a-id2:identifier
                                               (op :=)
                                               assign-rhs ...+
                                               (~and body2 (_::block . _)))))))
             #:do [(check-consistent #:who (syntax-e mode) #'alts (list #'a-id1 #'a-id2) "name")]
             #:attr form (wrap-class-clause #`(#,mode a-id1
                                               (block (group fun
                                                             (atag
                                                              (btag1 (group (parens) body1))
                                                              (btag2 (group (parens (group assign-rhs ...))
                                                                            body2)))))
                                               ret1.seq))))
  (define-splicing-syntax-class :property-decl
    #:description "proper declaration"
    #:attributes (id rhs maybe-ret)
    #:datum-literals (group)
    (pattern (~seq id:identifier ret::maybe-ret)
             #:attr rhs #'(block (group fun (alts (block (group (parens) (block (group (parsed (void))))))
                                                  (block (group (parens (group _)) (block (group (parsed (void)))))))))
             #:attr maybe-ret #'ret.seq)
    (pattern (~seq (_::alts (_::block (group id:identifier ret::maybe-ret))))
             #:attr rhs #'(block (group fun (parens) (block (group (parsed (void))))))
             #:attr maybe-ret #'ret.seq)))

(define-syntax constructor
  (class-clause-transformer
   (lambda (stx data)
     (syntax-parse stx
       #:datum-literals (group)
       [(_ id:identifier (~and args (_::parens . _)) ret ...
           (~and rhs (_::block . _)))
        (wrap-class-clause #`(constructor id (block (group fun args ret ... rhs))))]
       [(_ (~and args (_::parens . _)) ret ...
           (~and rhs (_::block . _)))
        (wrap-class-clause #`(constructor #f (block (group fun args ret ... rhs))))]
       [(_ (~and rhs (_::alts
                      (_::block id:identifier (group (_::parens . _) ret ...
                                                     (_::block . _)))
                      ...+)))
        #:with (id0 idx ...) #'(id ...)
        (for ([idx (in-list (syntax->list #'(idx ...)))])
          (unless (bound-identifier=? idx #'id0)
            (raise-syntax-error #f "inconsistent name identifier" stx idx)))
        (wrap-class-clause #`(constructor id0 (block (group fun rhs))))]
       [(_ (~and rhs (_::alts
                      (_::block (group (_::parens . _) ret ...
                                       (_::block . _)))
                      ...+)))
        (wrap-class-clause #`(constructor #f (block (group fun rhs))))]
       [(_ id:identifier (~and rhs (_::block . _)))
        (wrap-class-clause #`(constructor id rhs))]
       [(_ (~and rhs (_::block . _)))
        (wrap-class-clause #`(constructor #f rhs))]))))

(define-syntax expression
  (make-macro-clause-transformer #'expression))

(define-syntax final
  (make-class+interface-clause-transformer
   (lambda (stx data)
     (syntax-parse stx
       #:literals (override method property)
       [(_ override method (~var m (:method #'final-override))) #'m.form]
       [(_ method (~var m (:method #'final))) #'m.form]
       [(_ override property (~var m (:property #'final-override-property))) #'m.form]
       [(_ property (~var m (:property #'final-property))) #'m.form]
       [(_ override (~var m (:method #'final-override))) #'m.form]
       [(_ override property (~var m (:property #'final-override-property))) #'m.form]
       [(_ (~var m (:method #'final))) #'m.form]))))
(define-syntax final-override 'placeholder)
(define-syntax final-property 'placeholder)
(define-syntax final-override-property 'placeholder)

(define-syntax method
  (make-class+interface-clause-transformer
   ;; class clause
   (lambda (stx data)
     (syntax-parse stx
       [(_ (~var m (:method #'method))) #'m.form]))
   ;; interface clause
   (lambda (stx data)
     (syntax-parse stx
       [(_ (~var m (:method #'method))) #'m.form]
       [(_ decl::method-decl) (wrap-class-clause #'(abstract decl.id decl.rhs decl.maybe-ret))]))))

(define-syntax property
  (make-class+interface-clause-transformer
   ;; class clause
   (lambda (stx data)
     (syntax-parse stx
       [(_ (~var m (:property #'property))) #'m.form]))
   ;; interface clause
   (lambda (stx data)
     (syntax-parse stx
       [(_ (~var m (:property #'property))) #'m.form]
       [(_ decl::property-decl) (wrap-class-clause #'(abstract-property decl.id decl.rhs decl.maybe-ret))]))))

(define-syntax override
  (make-class+interface-clause-transformer
   ;; class clause
   (lambda (stx data)
     (syntax-parse stx
       #:literals (method)
       [(_ method (~var m (:method #'override))) #'m.form]
       [(_ property (~var m (:property #'override-property))) #'m.form]
       [(_ (~var m (:method #'override))) #'m.form]))
   (lambda (stx data)
     (syntax-parse stx
       #:literals (method)
       [(_ method (~var m (:method #'override))) #'m.form]
       [(_ method decl::method-decl) (wrap-class-clause #'(abstract-override decl.id decl.rhs decl.maybe-ret))]
       [(_ property (~var m (:property #'override-property))) #'m.form]
       [(_ property decl::property-decl) (wrap-class-clause #'(abstract-override-property decl.id decl.rhs decl.maybe-ret))]
       [(_ (~var m (:method #'override))) #'m.form]
       [(_ decl::method-decl) (wrap-class-clause #'(abstract-override decl.id decl.rhs decl.maybe-ret))]))))
(define-syntax override-property 'placeholder)

(define-syntax private
  (make-class+interface-clause-transformer
   ;; class clause
   (lambda (stx data)
     (syntax-parse stx
       #:literals (implements method override property)
       [(_ (~and tag implements) form ...)
        (wrap-class-clause #`(private-implements . #,(parse-multiple-names #'(tag form ...))))]
       [(_ method (~var m (:method #'private))) #'m.form]
       [(_ override (~var m (:method #'private-override))) #'m.form]
       [(_ override method (~var m (:method #'private-override))) #'m.form]
       [(_ property (~var m (:property #'private-property))) #'m.form]
       [(_ override property (~var m (:property #'private-override-property))) #'m.form]
       [(_ (~and (~seq field _ ...) (~var f (:field 'private)))) #'f.form]
       [(_ (~var m (:method #'private))) #'m.form]))
   ;; interface clause
   (lambda (stx data)
     (syntax-parse stx
       #:literals (method)
       [(_ method (~var m (:method #'private))) #'m.form]
       [(_ (~var m (:method #'private))) #'m.form]))))
(define-syntax private-implements 'placeholder)
(define-syntax private-override 'placeholder)
(define-syntax private-property 'placeholder)
(define-syntax private-override-property 'placeholder)

(define-syntax abstract
  (make-class+interface-clause-transformer
   (lambda (stx data)
     (syntax-parse stx
       #:literals (method override property)
       [(_ method decl::method-decl) (wrap-class-clause #'(abstract decl.id decl.rhs decl.maybe-ret))]
       [(_ property decl::property-decl) (wrap-class-clause #'(abstract-property decl.id decl.rhs decl.maybe-ret))]
       [(_ override decl::method-decl) (wrap-class-clause #'(abstract-override decl.id decl.rhs decl.maybe-ret))]
       [(_ override method decl::method-decl) (wrap-class-clause #'(abstract-override decl.id decl.rhs decl.maybe-ret))]
       [(_ override property decl::property-decl) (wrap-class-clause #'(abstract-override-property decl.id decl.rhs decl.maybe-ret))]
       [(_ decl::method-decl) (wrap-class-clause #'(abstract decl.id decl.rhs decl.maybe-ret))]))))
(define-syntax abstract-property 'placeholder)
(define-syntax abstract-override 'placeholder)
(define-syntax abstract-override-property 'placeholder)


(define-for-syntax (same-return-signature? a b)
  (cond
    [(identifier? a)
     (and (identifier? b)
          (free-identifier=? a b))]
    [(identifier? b) #f]
    [(syntax? a)
     (same-return-signature? (syntax-e a) b)]
    [(syntax? b)
     (same-return-signature? a (syntax-e b))]
    [(null? a) (null? b)]
    [(pair? a)
     (and (pair? b)
          (and (same-return-signature? (car a) (car b))
               (same-return-signature? (cdr a) (cdr b))))]
    [else (equal? a b)]))

(define (not-assignable name)
  (error name "property does not support assignment"))