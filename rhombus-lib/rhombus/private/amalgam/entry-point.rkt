#lang racket/base
(require (for-syntax racket/base
                     syntax/parse/pre
                     enforest/transformer
                     enforest/property
                     enforest/proc-name
                     "introducer.rkt"
                     "macro-result.rkt"
                     "to-list.rkt")
         "enforest.rkt")

(module+ for-class
  (provide (for-syntax in-entry-point-space)))

(provide define-entry-point-syntax)

(begin-for-syntax
  (provide (property-out entry-point-transformer)
           :entry-point
           :entry-point-shape
           check-entry-point-shape-result)

  (property entry-point-transformer transformer (shape-extract))

  (define (check-entry-point-result form proc adjustments)
    (unless (syntax? form)
      (raise-bad-macro-result (proc-name proc) "entry point" form))
    form)

  (define (check-entry-point-shape-result form-in proc)
    (define (bad)
      (raise-bad-macro-result (proc-name proc)
                              #:syntax-for? #f
                              "entry point shape" form-in))
    (define (arity-list? v)
      (and (pair? v)
           (pair? (cdr v))
           (pair? (cddr v))
           (null? (cdddr v))))
    (define (check-keyword-list v)
      (unless (and (list? v)
                   (andmap keyword? v))
        (bad))
      v)
    (define (arity-form form-in)
      (cond
        [(or (not form-in)
             (exact-integer? form-in))
         form-in]
        [else
         (define form (to-list #f form-in))
         (unless (arity-list? form) (bad))
         (define-values (mask required-kws-in allowed-kws-in)
           (values (car form) (cadr form) (caddr form)))
         (unless (exact-integer? mask) (bad))
         (define required-kws
           (check-keyword-list (to-list #f required-kws-in)))
         (define allowed-kws
           (cond
             [(not allowed-kws-in) allowed-kws-in]
             [else (check-keyword-list (to-list #f allowed-kws-in))]))
         (list mask required-kws allowed-kws)]))
    (define form
      (if (hash? form-in)
          (for/hash ([(k v) (in-hash form-in)])
            (case k
              [(arity) (values k (arity-form v))]
              [(name)
               (unless (symbol? v) (bad))
               (values k v)]
              [else (bad)]))
          (bad)))
    (datum->syntax #f form))

  (define in-entry-point-space (make-interned-syntax-introducer/add 'rhombus/entry_point))

  (define-rhombus-transform
    #:syntax-class (:entry-point adjustments)
    #:desc "entry-point form"
    #:parsed-tag #:rhombus/entry_point
    #:in-space in-entry-point-space
    #:transformer-ref entry-point-transformer-ref
    #:check-result check-entry-point-result)

  (define-rhombus-transform
    #:syntax-class :entry-point-shape
    #:desc "entry-point form"
    #:parsed-tag #:rhombus/entry_point
    #:in-space in-entry-point-space
    #:transformer-ref (lambda (v)
                        (define t (entry-point-transformer-ref v))
                        (and t (transformer (entry-point-transformer-shape-extract t))))
    #:check-result check-entry-point-shape-result))

(define-syntax (define-entry-point-syntax stx)
  (syntax-parse stx
    [(_ name:id rhs)
     (quasisyntax/loc stx
       (define-syntax #,(in-entry-point-space #'name) rhs))]))
