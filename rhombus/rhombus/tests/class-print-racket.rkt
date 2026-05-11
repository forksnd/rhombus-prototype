#lang racket/base

(provide a_o
         b_t
         c_o
         a_t
         b_o
         c_t)

(struct a_o (x y))
(struct b_t a_o (z) #:transparent)
(struct c_o b_t (w))

(struct a_t (x y) #:transparent)
(struct b_o a_t (z))
(struct c_t b_o (w) #:transparent)

