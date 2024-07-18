#lang racket/base

(provide render-pretty)

;; A greedy printer that is constrained to the set of commands
;; generated by `pretty-shrubbery` and assumes that `or` is ordered:
;; single-line (if possible) before multi-line. Among multi-line
;; options, it will always pick the latter one.

(define (render-pretty doc o
                       #:width [width #f] ; #f => always take first branch
                       #:column [col 0]
                       #:indent [indent 0]
                       #:write-special [write-special write-special])
  (define-syntax-rule (assume x) x)
  (let loop ([doc doc] [col col] [indent indent] [measure-mode #f] [k #f])
    (define (done column measure-mode)
      (cond
        [(and measure-mode (>= col width)) #f]
        [(not k) column]
        [else (k column measure-mode)]))
    (cond
      [(string? doc)
       (unless measure-mode (display doc o))
       (done (+ col (string-length doc)) measure-mode)]
      [(bytes? doc)
       (unless measure-mode (display doc o))
       (done (+ col (bytes-utf-8-length doc)) measure-mode)]
      [(eq? doc 'nl)
       (cond
         [(not measure-mode)
          (newline o)
          (display (make-string indent #\space) o)
          (done indent measure-mode)]
         [(eq? measure-mode 'single) #f]
         [else #t])]
      [(not (assume (and (pair? doc) (list? doc))))
       (error 'render-pretty "bad format ~v" doc)]
      [(eq? (car doc) 'seq)
       (cond
         [(not width)
          ;; no measure mode, so `k` is never needed
          (for/fold ([col col]) ([doc (in-list (cdr doc))])
            (loop doc col indent #f #f))]
         [else
          (let seq-loop ([docs (cdr doc)] [col col] [measure-mode measure-mode])
            (if (null? docs)
                (done col measure-mode)
                (let ([doc (car docs)]
                      [docs (cdr docs)])
                  (loop doc col indent measure-mode
                        (lambda (col measure-mode) (seq-loop docs col measure-mode))))))])]
      [(and (eq? (car doc) 'nest)
            (assume (= (length doc) 3)))
       (loop (caddr doc) col (+ indent (cadr doc)) measure-mode k)]
      [(and (eq? (car doc) 'align)
            (assume (= (length doc) 2)))
       (loop (cadr doc) col col measure-mode k)]
      [(and (eq? (car doc) 'or)
            (assume (= (length doc) 3)))
       (cond
         [(or (not width) measure-mode)
          ;; in single-line mode, always take the first branch
          (loop (cadr doc) col indent measure-mode k)]
         [else
          (define fits?
            (loop (cadr doc) col indent 'single (lambda (col measure-mode)
                                                  (done col 'afterward))))
          (cond
            [fits?
             (loop (cadr doc) col indent measure-mode k)]
            [else
             (loop (caddr doc) col indent measure-mode k)])])]
      [(eq? (car doc) 'special)
       (unless measure-mode (write-special (cadr doc) o))
       (done (+ col (caddr doc)) measure-mode)]
      [else
       (error 'render-pretty "bad format: ~v" doc)]))
  (void))