#lang racket/base
(require syntax/parse/pre)

(provide transfer-origin
         transfer-origins)

(define (transfer-origin src-stx-in stx)
  (define src-stx
    (syntax-parse src-stx-in
      #:datum-literals (parsed)
      [(parsed kw:keyword e) #'e]
      [_ src-stx-in]))
  (for/fold ([stx stx]) ([property-key (in-list '(origin disappeared-use disappeared-binding))])
    (define d (syntax-property src-stx property-key))
    (cond
      [d
       (define (add stx)
         (define d2 (syntax-property stx property-key))
         (syntax-property stx property-key (if d2 (cons d d2) d)))
       (syntax-parse stx
         #:datum-literals (parsed)
         [((~and tag parsed) kw:keyword e)
          (datum->syntax stx (list #'tag #'kw (add #'e)) stx stx)]
         [_ (add stx)])]
      [else
       stx])))

(define (transfer-origins src-stxes stx)
  (for/fold ([stx stx]) ([src-stx (in-list src-stxes)])
    (transfer-origin src-stx stx)))
