#lang racket
(provide (all-defined-out))

(define x 3) ;val x = 3
(define y (+ 2 x)) ; val y = (2 + x) ; + is a function call

(define cube1
  (lambda (x)
    (* x (* x x))))

(define cube2
  (lambda (x)
    (* x x x)))

(define (cube3 x)
  (* x x x))

(define (pow1 x y) ;x to the yth power (y must be nonnegative)
  (if (= y 0)
      1
      (* x (pow1 x (- y 1)))))

(define pow2 ; curryied function
  (lambda (x)
    (lambda (y)
      (pow1 x y))))

(define three-to-the (pow2 3)) ;partial application of the curried function