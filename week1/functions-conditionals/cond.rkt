#lang racket

(provide (all-defined-out))

(define (sum2 xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum2 (cdr xs)))]
        [#t (+ (sum2 (car xs)) (sum2 (cdr xs)))]))

