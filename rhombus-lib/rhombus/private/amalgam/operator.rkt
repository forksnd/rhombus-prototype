#lang racket/base
(require (for-syntax racket/base
                     syntax/parse/pre
                     "srcloc.rkt"
                     "consistent.rkt"
                     "same-expression.rkt"
                     "entry-point-adjustment.rkt")
         "expression.rkt"
         (only-in "repetition.rkt"
                  in-repetition-space
                  repet-quote
                  repetition-prefix+infix-operator)
         "compound-repetition.rkt"
         "dotted-sequence-parse.rkt"
         "parse.rkt"
         "macro-macro.rkt"
         "definition.rkt"
         "static-info.rkt"
         "parens.rkt"
         (submod "function-parse.rkt" for-build))

;; The `operator` form takes something that looks like a function-style
;; operator definition and generates a combination of a transformer and
;; a function

(provide (for-space rhombus/defn
                    (rename-out
                     [rhombus-operator operator])))

(begin-for-syntax

  (define-syntax-class :not-op
    #:description "non-operator"
    #:datum-literals (op)
    (pattern (~not (op _))))

  (define-syntax-class :not-op-or-block
    #:description "non-operator, non-block"
    #:datum-literals (op block alts)
    (pattern (~not (~or* (op _)
                         (block . _)
                         (alts . _)))))

  (define-splicing-syntax-class :prefix-case
    #:description "prefix operator case"
    #:datum-literals (group)
    (pattern (~seq (_::parens (~and g (group op-name-seq::dotted-operator-or-identifier-sequence arg::not-op)))
                   ret::ret-annotation
                   (tag::block
                    (~var options (:prefix-operator-options '#f))
                    body ...))
             #:with op-name::dotted-operator-or-identifier #'op-name-seq
             #:with name #'op-name.name
             #:with extends #'op-name.extends
             #:with order #'options.order-name
             #:with prec #'options.prec
             #:with who #'options.who
             #:with unsafe #'options.unsafe
             #:with reflect-name #'options.reflect-name
             #:with rhs #'(tag body ...)
             #:attr ret-converter (attribute ret.converter)
             #:attr ret-annot-str (attribute ret.annot-str)
             #:with ret-static-infos #'ret.static-infos)
    (pattern (~seq op-name-seq::dotted-operator-or-identifier-sequence arg::not-op-or-block
                   (tag::block
                    (~var options (:prefix-operator-options '#f))
                    body ...))
             #:with op-name::dotted-operator-or-identifier #'op-name-seq
             #:with name #'op-name.name
             #:with extends #'op-name.extends
             #:with order #'options.order-name
             #:with prec #'options.prec
             #:with who #'options.who
             #:with unsafe #'options.unsafe
             #:with reflect-name #'options.reflect-name
             #:with rhs #'(tag body ...)
             #:attr ret-converter #f
             #:attr ret-annot-str #f
             #:with ret-static-infos #'()
             #:with g #'(group op-name-seq arg)))

  (define-splicing-syntax-class :infix-case
    #:description "infix operator case"
    #:datum-literals (group)
    (pattern (~seq (_::parens (~and g (group left::not-op op-name-seq::dotted-operator-or-identifier-sequence right::not-op)))
                   ret::ret-annotation
                   (tag::block
                    (~var options (:infix-operator-options '#f))
                    body ...))
             #:with op-name::dotted-operator-or-identifier #'op-name-seq
             #:with name #'op-name.name
             #:with extends #'op-name.extends
             #:with order #'options.order-name
             #:with prec #'options.prec
             #:with assc #'options.assc
             #:with who #'options.who
             #:with unsafe #'options.unsafe
             #:with reflect-name #'options.reflect-name
             #:with rhs #'(tag body ...)
             #:attr ret-converter (attribute ret.converter)
             #:attr ret-annot-str (attribute ret.annot-str)
             #:with ret-static-infos #'ret.static-infos)
    (pattern (~seq left::not-op op-name-seq::dotted-operator-or-identifier-sequence right::not-op-or-block
                   (tag::block
                    (~var options (:infix-operator-options '#f))
                    body ...))
             #:with op-name::dotted-operator-or-identifier #'op-name-seq
             #:with name #'op-name.name
             #:with extends #'op-name.extends
             #:with order #'options.order-name
             #:with prec #'options.prec
             #:with assc #'options.assc
             #:with who #'options.who
             #:with unsafe #'options.unsafe
             #:with reflect-name #'options.reflect-name
             #:with rhs #'(tag body ...)
             #:attr ret-converter #f
             #:attr ret-annot-str #f
             #:with ret-static-infos #'()
             #:with g #'(group left op-name-seq right)))

  (define-splicing-syntax-class :postfix-case
    #:description "postfix operator case"
    #:datum-literals (group)
    (pattern (~seq (_::parens (~and g (group arg::not-op op-name-seq::dotted-operator-or-identifier-sequence)))
                   ret::ret-annotation
                   (tag::block
                    (~var options (:prefix-operator-options '#f))
                    body ...))
             #:with op-name::dotted-operator-or-identifier #'op-name-seq
             #:with name #'op-name.name
             #:with extends #'op-name.extends
             #:with order #'options.order-name
             #:with prec #'options.prec
             #:with who #'options.who
             #:with unsafe #'options.unsafe
             #:with reflect-name #'options.reflect-name
             #:with rhs #'(tag body ...)
             #:attr ret-converter (attribute ret.converter)
             #:attr ret-annot-str (attribute ret.annot-str)
             #:with ret-static-infos #'ret.static-infos)
    (pattern (~seq arg::not-op op-name-seq::dotted-operator-or-identifier-sequence
                   (tag::block
                    (~var options (:prefix-operator-options '#f))
                    body ...))
             #:with op-name::dotted-operator-or-identifier #'op-name-seq
             #:with name #'op-name.name
             #:with extends #'op-name.extends
             #:with order #'options.order-name
             #:with prec #'options.prec
             #:with who #'options.who
             #:with unsafe #'options.unsafe
             #:with reflect-name #'options.reflect-name
             #:with rhs #'(tag body ...)
             #:attr ret-converter #f
             #:attr ret-annot-str #f
             #:with ret-static-infos #'()
             #:with g #'(group arg op-name-seq)))

  (define (make-prefix name op-proc unsafe/s order prec static-infos)
    (with-syntax ([op-proc op-proc])
      #`(make-expression&repetition-prefix-operator
         #,(convert-order order)
         #,(convert-prec prec)
         'prefix
         (lambda (right self-stx)
           (wrap-static-info*
            (relocate (span-srcloc self-stx right)
                      (maybe-unsafe
                       (quote-syntax #,unsafe/s)
                       #`(op-proc #,(discard-static-infos right))))
            (quote-syntax #,static-infos))))))

  (define (make-infix name op-proc unsafe/s order prec assc static-infos)
    (with-syntax ([op-proc op-proc])
      #`(make-expression&repetition-infix-operator
         #,(convert-order order)
         #,(convert-prec prec)
         'infix
         (lambda (left right self-stx)
           (wrap-static-info*
            (relocate (span-srcloc left right)
                      (maybe-unsafe
                       (quote-syntax #,unsafe/s)
                       #`(op-proc #,(discard-static-infos left)
                                  #,(discard-static-infos right))))
            (quote-syntax #,static-infos)))
         #,(convert-assc assc order))))

  (define (make-postfix name op-proc unsafe/s order prec static-infos)
    (with-syntax ([op-proc op-proc])
      #`(make-expression&repetition-infix-operator
         #,(convert-order order)
         #,(convert-prec prec)
         'postfix
         (lambda (left self-stx)
           (wrap-static-info*
            (relocate (span-srcloc left self-stx)
                      (maybe-unsafe
                       (quote-syntax #,unsafe/s)
                       #`(op-proc #,(discard-static-infos left))))
            (quote-syntax #,static-infos)))
         'none)))

  (define (maybe-unsafe unsafe/s call)
    (cond
      [(null? (syntax-e unsafe/s)) call]
      [else
       (syntax-parse call
         [(rator rand ...)
          #:with (tmp ...) (generate-temporaries #'(rand ...))
          #`(let ([tmp rand]
                  ...)
              (if (variable-reference-from-unsafe? (#%variable-reference))
                  (#,@unsafe/s tmp ...)
                  (rator tmp ...)))])]))

  (define (parse-binding arg)
    (syntax-parse #`(group #,arg)
      [arg::binding #'arg.parsed]))

  (define stx-or
    (case-lambda
      [(stx) (and (syntax-e stx) stx)]
      [(stx stx2) (if (syntax-e stx) stx stx2)]))

  (define (build-unary-function orig-stx name
                                main-converter main-annot-str
                                args rhss
                                ret-converters ret-annot-strs
                                reflect-names main-who whos
                                has-unsafe? unsafes)
    (define arg-parseds (map parse-binding args))
    (when has-unsafe?
      (for ([arg (in-list args)])
        (check-arg-for-unsafe orig-stx #`(group #,arg) #f)))
    (define falses (for/list ([a (in-list args)]) #f))
    (define falsess (for/list ([a (in-list args)]) #'(#f)))
    (define use-name (stx-or (car reflect-names) name))
    (define (->stx l) (datum->syntax #f l))
    (define-values (proc arity)
      (cond
        [(and (pair? args) (null? (cdr args))
              (not main-converter))
         (build-function no-adjustments '()
                         use-name (stx-or main-who) (stx-or (car whos))
                         (car falsess) (->stx args) (->stx arg-parseds) (car falsess)
                         #'#f #'#f
                         #'#f #'#f
                         (car ret-converters) (car ret-annot-strs)
                         (car rhss)
                         orig-stx)]
        [else
         (define falses (->stx (for/list ([a (in-list args)]) #'#f)))
         (define main-whos (for/list ([who (in-list whos)]) (stx-or main-who)))
         (build-case-function no-adjustments '()
                              use-name main-whos (map stx-or whos)
                              main-converter main-annot-str
                              (->stx falsess) (->stx (map list args)) (->stx (map list arg-parseds))
                              falses falses
                              falses falses
                              ret-converters ret-annot-strs
                              (->stx rhss)
                              orig-stx)]))
    (cond
      [has-unsafe?
       #`(values #,proc
                 #,(cond
                     [(and (pair? args) (null? (cdr args)))
                      (build-unsafe-function (car falsess) (->stx args) (->stx arg-parseds)
                                             #'#f #'#f
                                             (car unsafes)
                                             orig-stx)]
                     [else
                      (build-unsafe-case-function falsess args arg-parseds
                                                  falses falses
                                                  unsafes
                                                  orig-stx)]))]
      [else
       proc]))

  (define (build-binary-function orig-stx name
                                 main-converter main-annot-str
                                 lefts rights rhss
                                 ret-converters ret-annot-strs
                                 reflect-names main-who whos
                                 has-unsafe? unsafes)
    (define-values (left-parseds right-parseds)
      (for/lists (left-parseds right-parseds) ([left (in-list lefts)]
                                               [right (in-list rights)])
        (values (parse-binding left) (parse-binding right))))
    (when has-unsafe?
      (for ([arg (in-list (append lefts rights))])
        (check-arg-for-unsafe orig-stx #`(group #,arg) #f)))
    (define falsess (for/list ([a (in-list lefts)]) #'(#f #f)))
    (define use-name (stx-or (car reflect-names) name))
    (define (->stx l) (datum->syntax #f l))
    (define-values (proc arity)
      (cond
        [(and (pair? lefts) (null? (cdr lefts))
              (not main-converter))
         (build-function no-adjustments '()
                         use-name (stx-or main-who) (stx-or (car whos))
                         (car falsess)
                         (->stx (list (car lefts) (car rights)))
                         (->stx (list (car left-parseds) (car right-parseds)))
                         (car falsess)
                         #'#f #'#f
                         #'#f #'#f
                         (car ret-converters) (car ret-annot-strs)
                         (car rhss)
                         orig-stx)]
        [else
         (define falses (->stx (for/list ([a (in-list lefts)]) #'#f)))
         (define main-whos (for/list ([who (in-list whos)]) (stx-or main-who)))
         (build-case-function no-adjustments '()
                              use-name main-whos (map stx-or whos)
                              main-converter main-annot-str
                              (->stx falsess)
                              (->stx (map list lefts rights))
                              (->stx (map list left-parseds right-parseds))
                              falses falses
                              falses falses
                              ret-converters ret-annot-strs
                              (->stx rhss)
                              orig-stx)]))
    (cond
      [has-unsafe?
       #`(values #,proc
                 #,(cond
                     [(and (pair? lefts) (null? (cdr lefts)))
                      (build-unsafe-function (car falsess)
                                             (->stx (list (car lefts) (car rights)))
                                             (->stx (list (car left-parseds) (car right-parseds)))
                                             #'#f #'#f
                                             (car unsafes)
                                             orig-stx)]
                     [else
                      (define falses (->stx (for/list ([a (in-list lefts)]) #'#f)))
                      (build-unsafe-case-function (->stx falsess)
                                                  (->stx (map list lefts rights))
                                                  (->stx (map list left-parseds right-parseds))
                                                  falses falses
                                                  unsafes
                                                  orig-stx)]))]
      [else
       proc]))

  (define (generate-prefix stx main-who name extends args order prec rhss
                           ret-converters ret-annot-strs ret-static-infos
                           reflect-names whos unsafes
                           #:main-converter [main-converter #f]
                           #:main-annot-str [main-annot-str #f])
    (define has-unsafe? (check-consistent-unsafes stx "infix" unsafes))
    (with-syntax ([(op-proc) (generate-temporaries (list name))]
                  [(unsafe-proc ...) (generate-temporaries (if has-unsafe? (list name) null))])
      (cons
       #`(define-values (op-proc unsafe-proc ...)
           #,(build-unary-function stx name
                                   main-converter main-annot-str
                                   args rhss
                                   ret-converters ret-annot-strs
                                   reflect-names main-who whos
                                   has-unsafe? unsafes))
       (build-syntax-definitions/maybe-extension
        '(#f rhombus/repet) name extends
        (make-prefix name #'op-proc #'(unsafe-proc ...) order prec ret-static-infos)))))

  (define (generate-infix stx main-who name extends lefts rights order prec assc rhss
                          ret-converters ret-annot-strs ret-static-infos
                          reflect-names whos unsafes
                          #:main-converter [main-converter #f]
                          #:main-annot-str [main-annot-str #f])
    (define has-unsafe? (check-consistent-unsafes stx "infix" unsafes))
    (with-syntax ([(op-proc) (generate-temporaries (list name))]
                  [(unsafe-proc ...) (generate-temporaries (if has-unsafe? (list name) null))])
      (add-top-level
       #'(op-proc)
       (append
        (build-syntax-definitions/maybe-extension
         '(#f rhombus/repet) name extends
         (make-infix name #'op-proc #'(unsafe-proc ...) order prec assc ret-static-infos))
        (list
         #`(define-values (op-proc unsafe-proc ...)
             #,(build-binary-function stx name
                                      main-converter main-annot-str
                                      lefts rights rhss
                                      ret-converters ret-annot-strs
                                      reflect-names main-who whos
                                      has-unsafe? unsafes)))))))

  (define (generate-postfix stx main-who name extends args order prec rhss
                            ret-converters ret-annot-strs ret-static-infos
                            reflect-names whos unsafes
                            #:main-converter [main-converter #f]
                            #:main-annot-str [main-annot-str #f])
    (define has-unsafe? (check-consistent-unsafes stx "infix" unsafes))
    (with-syntax ([(op-proc) (generate-temporaries (list name))]
                  [(unsafe-proc ...) (generate-temporaries (if has-unsafe? (list name) null))])
      (add-top-level
       #'(op-proc unsafe-proc ...)
       (append
        (build-syntax-definitions/maybe-extension
         '(#f rhombus/repet) name extends
         (make-postfix name #'op-proc #'(unsafe-proc ...) order prec ret-static-infos))
        (list
         #`(define-values (op-proc unsafe-proc ...)
             #,(build-unary-function stx name
                                     main-converter main-annot-str
                                     args rhss
                                     ret-converters ret-annot-strs
                                     reflect-names main-who whos
                                     has-unsafe? unsafes)))))))

  (define (generate-prefix+infix stx
                                 main-who
                                 p-name p-extends p-args p-order p-prec p-rhss
                                 p-ret-converters p-ret-annot-strs p-ret-static-infos
                                 p-reflect-names p-whos p-unsafes
                                 i-name i-extends i-lefts i-rights i-order i-prec i-assc i-rhss
                                 i-ret-converters i-ret-annot-strs i-ret-static-infos
                                 i-reflect-names i-whos i-unsafes
                                 #:main-converter [main-converter #f]
                                 #:main-annot-str [main-annot-str #f])
    (define p-has-unsafe? (check-consistent-unsafes stx "prefix" p-unsafes))
    (define i-has-unsafe? (check-consistent-unsafes stx "infix" i-unsafes))
    (with-syntax ([(p-op-proc i-op-proc) (generate-temporaries (list p-name i-name))]
                  [(p-unsafe-proc ...) (generate-temporaries (if p-has-unsafe? (list p-name) null))]
                  [(i-unsafe-proc ...) (generate-temporaries (if i-has-unsafe? (list i-name) null))])
      (add-top-level
       #'(p-op-proc i-op-proc p-unsafe-proc ... i-unsafe-proc ...)
       (append
        (build-syntax-definitions/maybe-extension
         '(#f rhombus/repet) p-name p-extends
         #`(let-values ([(prefix-expr prefix-repet)
                         #,(make-prefix p-name #'p-op-proc #'(p-unsafe-proc ...) p-order p-prec p-ret-static-infos)]
                        [(infix-expr infix-repet)
                         #,(make-infix i-name #'i-op-proc #'(i-unsafe-proc ...) i-order i-prec i-assc i-ret-static-infos)])
             (values
              (expression-prefix+infix-operator prefix-expr infix-expr)
              (repetition-prefix+infix-operator prefix-repet infix-repet))))
        (list
         #`(define-values (p-op-proc p-unsafe-proc ...)
             #,(build-unary-function stx p-name
                                     main-converter main-annot-str
                                     p-args p-rhss
                                     p-ret-converters p-ret-annot-strs
                                     p-reflect-names main-who p-whos
                                     p-has-unsafe? p-unsafes))
         #`(define-values (i-op-proc i-unsafe-proc ...)
             #,(build-binary-function stx i-name
                                      main-converter main-annot-str
                                      i-lefts i-rights i-rhss
                                      i-ret-converters i-ret-annot-strs
                                      i-reflect-names main-who i-whos
                                      i-has-unsafe? i-unsafes)))))))

  (define (generate-prefix+postfix stx
                                   main-who
                                   p-name p-extends p-args p-order p-prec p-rhss
                                   p-ret-converters p-ret-annot-strs p-ret-static-infos
                                   p-reflect-names p-whos p-unsafes
                                   a-name a-extends a-args a-order a-prec a-rhss
                                   a-ret-converters a-ret-annot-strs a-ret-static-infos
                                   a-reflect-names a-whos a-unsafes
                                   #:main-converter [main-converter #f]
                                   #:main-annot-str [main-annot-str #f])
    (define p-has-unsafe? (check-consistent-unsafes stx "prefix" p-unsafes))
    (define a-has-unsafe? (check-consistent-unsafes stx "postfix" a-unsafes))
    (with-syntax ([(p-op-proc a-op-proc) (generate-temporaries (list p-name a-name))]
                  [(p-unsafe-proc ...) (generate-temporaries (if p-has-unsafe? (list p-name) null))]
                  [(a-unsafe-proc ...) (generate-temporaries (if a-has-unsafe? (list a-name) null))])
      (add-top-level
       #'(p-op-proc a-op-proc p-unsafe-proc ... a-unsafe-proc ...)
       (append
        (build-syntax-definitions/maybe-extension
         '(#f rhombus/repet) p-name p-extends
         #`(let-values ([(prefix-expr prefix-repet)
                         #,(make-prefix p-name #'p-op-proc #'(p-unsafe-proc ...) p-order p-prec p-ret-static-infos)]
                        [(infix-expr infix-repet)
                         #,(make-postfix a-name #'a-op-proc #'(a-unsafe-proc ...) a-order a-prec a-ret-static-infos)])
             (values
              (expression-prefix+infix-operator prefix-expr infix-expr)
              (repetition-prefix+infix-operator prefix-repet infix-repet))))
        (list
         #`(define-values (p-op-proc p-unsafe-proc ...)
             #,(build-unary-function stx p-name
                                     main-converter main-annot-str
                                     p-args p-rhss
                                     p-ret-converters p-ret-annot-strs
                                     p-reflect-names main-who p-whos
                                     p-has-unsafe? p-unsafes))
         #`(define-values (a-op-proc a-unsafe-proc ...)
             #,(build-unary-function stx a-name
                                     main-converter main-annot-str
                                     a-args a-rhss
                                     a-ret-converters a-ret-annot-strs
                                     a-reflect-names main-who a-whos
                                     a-has-unsafe? a-unsafes)))))))

  (define (add-top-level binds defns)
    (if (eq? 'top-level (syntax-local-context))
        (cons #`(define-syntaxes #,binds (values)) defns)
        defns))

  (define (check-consistent-unsafes stx what unsafes)
    (cond
      [(ormap syntax-e unsafes)
       (unless (andmap syntax-e unsafes)
         (raise-syntax-error #f
                             (format "unsafe ~a case present, but not every ~a case has an unsafe block"
                                     what what)
                             stx
                             (ormap (lambda (unsafe)
                                      (syntax-parse unsafe
                                        [(_ kw . _) #'kw]
                                        [_ #f]))
                                    unsafes)))
       #t]
      [else #f])))

(begin-for-syntax
  (struct opcase (name extends order prec rhs ret-converter ret-annot-str ret-static-infos orig-reflect-name reflect-name who unsafe))
  (struct unary-opcase opcase (arg))
  (struct binary-opcase opcase (left right assc)))

;; NOTE postfix case must be before infix case, otherwise something
;; like `(arg some.op) :: Annot` will proceed as an "infix" case.
(define-defn-syntax rhombus-operator
  (definition-transformer
    (lambda (stx name-prefix)
      (syntax-parse stx
        [(_ p::prefix-case)
         (generate-prefix stx #'#f #'p.name #'p.extends (list #'p.arg) #'p.order #'p.prec (list #'p.rhs)
                          (list (attribute p.ret-converter))
                          (list (attribute p.ret-annot-str))
                          #'p.ret-static-infos
                          (list #'p.reflect-name) (list #'p.who) (list #'p.unsafe))]
        [(_ p::postfix-case)
         (generate-postfix stx #'#f #'p.name #'p.extends (list #'p.arg) #'p.order #'p.prec (list #'p.rhs)
                           (list (attribute p.ret-converter))
                           (list (attribute p.ret-annot-str))
                           #'p.ret-static-infos
                           (list #'p.reflect-name) (list #'p.who) (list #'p.unsafe))]
        [(_ i::infix-case)
         (generate-infix stx #'#f #'i.name #'i.extends (list #'i.left) (list #'i.right) #'i.order #'i.prec #'i.assc (list #'i.rhs)
                         (list (attribute i.ret-converter))
                         (list (attribute i.ret-annot-str))
                         #'i.ret-static-infos
                         (list #'i.reflect-name) (list #'i.who) (list #'i.unsafe))]
        [(_ (_::alts . as))
         (parse-operator-alts stx #'as
                              #f
                              #f #f #f
                              #'() #'() #'()
                              #'#f #'#f)]
        [(_ main-op-name-seq::dotted-operator-or-identifier-sequence
            main-ret::ret-annotation
            (~optional (_::block (~var options (:all-operator-options '#f))))
            (_::alts . as))
         #:with main-op-name::dotted-operator-or-identifier #'main-op-name-seq
         (parse-operator-alts stx #'as
                              #'main-op-name.name
                              (attribute main-ret.converter)
                              (attribute main-ret.annot-str)
                              #'main-ret.static-infos
                              #'(~? options.order-name ())
                              #'(~? options.prec ())
                              #'(~? options.assc ())
                              #'(~? options.reflect-name #f)
                              #'(~? options.who #f))]))))

(define-for-syntax (parse-operator-alts stx as-stx
                                        main-name
                                        main-ret-converter main-ret-annot-str main-ret-static-infos
                                        main-order main-prec main-assc
                                        main-reflect-name main-who)
  (define (maybe-static-infos/main ops)
    (or main-ret-static-infos
        (let ([static-infoss (map opcase-ret-static-infos ops)])
          (and (for/and ([static-infos (in-list (cdr static-infoss))])
                 (same-expression? (car static-infoss) static-infos))
               (car static-infoss)))
        #'()))
  (define-values (all pres ins posts)
    (for/fold ([all '()] [pres '()] [ins '()] [posts '()] [use-main-reflect-name main-reflect-name]
               #:result (values (reverse all) (reverse pres) (reverse ins) (reverse posts)))
              ([a (in-list (syntax->list as-stx))])
      (syntax-parse a
        #:datum-literals (group)
        [(_::block (group p::prefix-case))
         (define opc (unary-opcase #'p.name #'p.extends
                                   #'p.order #'p.prec #'p.rhs
                                   (attribute p.ret-converter)
                                   (attribute p.ret-annot-str)
                                   #'p.ret-static-infos
                                   #'p.reflect-name (stx-or #'p.reflect-name use-main-reflect-name) #'p.who #'p.unsafe
                                   #'p.arg))
         (values (cons opc all) (cons opc pres) ins posts (stx-or #'p.reflect-name use-main-reflect-name))]
        [(_::block (group p::postfix-case))
         (define opc (unary-opcase #'p.name #'p.extends
                                   #'p.order #'p.prec #'p.rhs
                                   (attribute p.ret-converter)
                                   (attribute p.ret-annot-str)
                                   #'p.ret-static-infos
                                   #'p.reflect-name (stx-or #'p.reflect-name use-main-reflect-name) #'p.who #'p.unsafe
                                   #'p.arg))
         (values (cons opc all) pres ins (cons opc posts) (stx-or #'p.reflect-name use-main-reflect-name))]
        [(_::block (group i::infix-case))
         (define opc (binary-opcase #'i.name #'i.extends
                                    #'i.order #'i.prec #'i.rhs
                                    (attribute i.ret-converter)
                                    (attribute i.ret-annot-str)
                                    #'i.ret-static-infos
                                    #'i.reflect-name (stx-or #'i.reflect-name use-main-reflect-name) #'i.who #'i.unsafe
                                    #'i.left #'i.right #'i.assc))
         (values (cons opc all) pres (cons opc ins) posts (stx-or #'p.reflect-name use-main-reflect-name))])))
  (check-consistent stx
                    (let ([names (map opcase-name all)])
                      (if main-name
                          (cons main-name names)
                          names))
                    #:has-main? (and main-name #t)
                    "operator")
  (when (and (pair? ins) (pair? posts))
    (raise-syntax-error #f
                        "combination of infix and postfix cases not allowed"
                        stx))
  (define (check-options opcs main-opcs extract options what)
    (unless (null? opcs)
      (for ([opc (in-list (if (null? (syntax-e main-opcs)) (cdr opcs) opcs))])
        (when (and (syntax-e (extract opc))
                   (not (null? (syntax-e (extract opc)))))
          (raise-syntax-error #f
                              (format "~a option not allowed ~a ~a case"
                                      options
                                      (if (null? (syntax-e main-opcs)) "after first" "in")
                                      what)
                              stx)))))
  (check-options pres main-order opcase-order "operator order" "prefix")
  (check-options pres main-prec opcase-prec "precedence" "prefix")
  (check-options ins main-order opcase-order "operator order" "infix")
  (check-options ins main-prec opcase-prec "precedence" "infix")
  (check-options ins main-assc binary-opcase-assc "associativity" "infix")
  (check-options posts main-order opcase-order "operator order" "postfix")
  (check-options posts main-prec opcase-prec "precedence" "postfix")
  (when (and (null? ins)
             (not (null? (syntax-e main-assc))))
    (raise-syntax-error #f
                        "associativity specified without infix cases"
                        stx
                        main-assc))
  (check-options all (stx-or main-reflect-name #'()) opcase-orig-reflect-name "name" "operator")
  (define (opcase-order/main opc) (if (null? (syntax-e main-order))
                                      (opcase-order opc)
                                      main-order))
  (define (opcase-prec/main opc) (if (null? (syntax-e main-prec))
                                     (opcase-prec opc)
                                     main-prec))
  (define (binary-opcase-assc/main opc) (if (null? (syntax-e main-assc))
                                            (binary-opcase-assc opc)
                                            main-assc))
  (cond
    [(and (null? ins) (null? posts))
     (generate-prefix stx
                      #:main-converter main-ret-converter
                      #:main-annot-str main-ret-annot-str
                      main-who
                      (opcase-name (car pres)) (opcase-extends (car pres))
                      (map unary-opcase-arg pres) (opcase-order/main (car pres)) (opcase-prec/main (car pres)) (map opcase-rhs pres)
                      (map opcase-ret-converter pres) (map opcase-ret-annot-str pres) (maybe-static-infos/main pres)
                      (map opcase-reflect-name pres) (map opcase-who pres) (map opcase-unsafe pres))]
    [(and (null? pres) (null? posts))
     (generate-infix stx
                     #:main-converter main-ret-converter
                     #:main-annot-str main-ret-annot-str
                     main-who
                     (opcase-name (car ins)) (opcase-extends (car ins))
                     (map binary-opcase-left ins) (map binary-opcase-right ins)
                     (opcase-order/main (car ins)) (opcase-prec/main (car ins)) (binary-opcase-assc/main (car ins))
                     (map opcase-rhs ins)
                     (map opcase-ret-converter ins) (map opcase-ret-annot-str ins) (maybe-static-infos/main ins)
                     (map opcase-reflect-name ins) (map opcase-who ins) (map opcase-unsafe ins))]
    [(and (null? pres) (null? ins))
     (generate-postfix stx
                       #:main-converter main-ret-converter
                       #:main-annot-str main-ret-annot-str
                       main-who
                       (opcase-name (car posts)) (opcase-extends (car posts))
                       (map unary-opcase-arg posts) (opcase-order/main (car posts)) (opcase-prec/main (car posts)) (map opcase-rhs posts)
                       (map opcase-ret-converter posts) (map opcase-ret-annot-str posts) (maybe-static-infos/main posts)
                       (map opcase-reflect-name posts) (map opcase-who posts) (map opcase-unsafe posts))]
    [(pair? ins)
     (generate-prefix+infix stx
                            #:main-converter main-ret-converter
                            #:main-annot-str main-ret-annot-str
                            main-who
                            (opcase-name (car pres)) (opcase-extends (car pres))
                            (map unary-opcase-arg pres) (opcase-order/main (car pres)) (opcase-prec/main (car pres)) (map opcase-rhs pres)
                            (map opcase-ret-converter pres) (map opcase-ret-annot-str pres) (maybe-static-infos/main pres)
                            (map opcase-reflect-name pres) (map opcase-who pres) (map opcase-unsafe pres)

                            (opcase-name (car ins)) (opcase-extends (car ins))
                            (map binary-opcase-left ins) (map binary-opcase-right ins)
                            (opcase-order/main (car ins)) (opcase-prec/main (car ins)) (binary-opcase-assc/main (car ins))
                            (map opcase-rhs ins)
                            (map opcase-ret-converter ins) (map opcase-ret-annot-str ins) (maybe-static-infos/main ins)
                            (map opcase-reflect-name ins) (map opcase-who ins) (map opcase-unsafe ins))]
    [else
     (generate-prefix+postfix stx
                              #:main-converter main-ret-converter
                              #:main-annot-str main-ret-annot-str
                              main-who
                              (opcase-name (car pres)) (opcase-extends (car pres))
                              (map unary-opcase-arg pres) (opcase-order/main (car pres)) (opcase-prec/main (car pres)) (map opcase-rhs pres)
                              (map opcase-ret-converter pres) (map opcase-ret-annot-str pres) (maybe-static-infos/main pres)
                              (map opcase-reflect-name pres) (map opcase-who pres) (map opcase-unsafe pres)

                              (opcase-name (car posts)) (opcase-extends (car posts))
                              (map unary-opcase-arg posts) (opcase-order/main (car posts)) (opcase-prec/main (car posts)) (map opcase-rhs posts)
                              (map opcase-ret-converter posts) (map opcase-ret-annot-str posts) (maybe-static-infos/main posts)
                              (map opcase-reflect-name posts) (map opcase-who posts) (map opcase-unsafe posts))]))
