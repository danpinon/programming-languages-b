#lang racket

(define xs (list 4 5 6))
(define ys (list (list (list 5 0)) 5 6 (list 8) 9 2 3 (list 0 1)))

(define (sum1 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum1 (cdr xs)))
          (+ (sum1 (car xs)) (sum1 (cdr xs))))))