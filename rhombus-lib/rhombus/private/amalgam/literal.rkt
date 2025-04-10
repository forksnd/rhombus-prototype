#lang racket/base
(require (for-syntax racket/base
                     syntax/parse/pre
                     shrubbery/print
                     "annotation-string.rkt")
         "binding.rkt"
         "static-info.rkt"
         "number.rkt")

(provide literal-infoer
         literal-now-infoer
         ;; useful for other binding patterns:
         literal-commit-nothing
         literal-bind-nothing)

(module+ for-info
  (provide (for-syntax (rename-out [get-string-static-infos indirect-get-string-static-infos]
                                   [get-bytes-static-infos indirect-get-bytes-static-infos])
                       install-get-literal-static-infos!
                       literal-static-infos)))

(define-syntax (literal-infoer stx)
  (parse-literal-infoer stx #'equal-always? #t))

(define-syntax (literal-now-infoer stx)
  (parse-literal-infoer stx #'equal? #f))

(define-for-syntax (parse-literal-infoer stx eql?-stx always?)
  (syntax-parse stx
    [(_ up-static-infos (~and data ([datum0 str0] [datum str] ...)))
     (binding-info (annotation-string-from-pattern
                    (apply string-append
                           (syntax-e #'str0)
                           (for/list ([str (in-list (syntax->list #'(str ...)))])
                             (string-append " || " (syntax-e str)))))
                   #'literal
                   (static-infos-and
                    (or (for/fold ([si (literal-static-infos #'datum0)])
                                  ([datum (in-list (syntax->list #'(datum ...)))])
                          #:break (not si)
                          (cond
                            [(literal-static-infos datum always?)
                             => (lambda (more-si)
                                  (static-infos-or si more-si))]
                            [else #f]))
                        #'())
                    #'up-static-infos)
                   #'()
                   #'empty-oncer
                   #'literal-matcher
                   #'()
                   #'literal-commit-nothing
                   #'literal-bind-nothing
                   #`(#,eql?-stx . data))]))

(define-syntax (literal-matcher stx)
  (syntax-parse stx
    [(_ arg-id (eql? [datum _] ...) IF success fail)
     #'(IF (or (eql? arg-id (quote datum))
               ...)
           success
           fail)]))

(define-syntax (literal-commit-nothing stx)
  (syntax-parse stx
    [(_ arg-id () data)
     #'(begin)]))

(define-syntax (literal-bind-nothing stx)
  (syntax-parse stx
    [(_ arg-id () data)
     #'(begin)]))

(define-for-syntax get-string-static-infos #f)
(define-for-syntax get-readable-string-static-infos #f)
(define-for-syntax get-bytes-static-infos #f)
(define-for-syntax get-char-static-infos #f)
(define-for-syntax (install-get-literal-static-infos! kind get-static-infos)
  (case kind
    [(string) (set! get-string-static-infos get-static-infos)]
    [(readable-string) (set! get-readable-string-static-infos get-static-infos)]
    [(bytes) (set! get-bytes-static-infos get-static-infos)]
    [(char) (set! get-char-static-infos get-static-infos)]
    [else (error "unrecognized kind" kind)]))

(define-for-syntax (literal-static-infos d-stx [always? #t])
  (define d (syntax-e d-stx))
  (or (and (string? d) (if always?
                           (get-string-static-infos)
                           (get-readable-string-static-infos)))
      (and (bytes? d) (get-bytes-static-infos))
      (and (exact-integer? d) (get-int-static-infos))
      (and (flonum? d) (get-flonum-static-infos))
      (and (rational? d) (get-rational-static-infos))
      (and (real? d) (get-real-static-infos))
      (and (number? d) (get-number-static-infos))
      (and (char? d) (get-char-static-infos))))
