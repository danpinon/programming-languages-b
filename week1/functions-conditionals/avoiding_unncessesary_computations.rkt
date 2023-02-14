#lang racket

;an slow computation
(define (slow-add x y)
  (letrec ([slow-id (lambda (y z)
                      (if (= 0 z)
                          y
                          (slow-id y (- z 1))))])
    (+ (slow-id x 50000000) y)))
; Delay and Force

(define (my-delay thunk)
  (mcons #f thunk)); return a pair '(false, thunk), a one-of "type"

(define (my-force pair)
  (if (mcar pair) ; if the first element of the pair is true return the computed value
      (mcdr pair) ; return the computed value
      (begin (set-mcar! pair #t) ; else set the first element of the pair to true
             (set-mcdr! pair ((mcdr pair))) ;then execute the thunk and set it to the second element of the pair
             (mcdr pair)))) ; return the thunk value (second element of the pair)

; for example, here is a uneficient way of calling the thunk
; multiplies x and the result of y-thunk, calling y-thunk x times
(define (my-mult x y-thunk)
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)] ; one call of the thunk, not bad
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))])); this recursive call will execute the thunk many times, this will take a lot of time

; Implementation of delay and force
#|
(my-mult x (let ([promise (my-delay (lambda () (slow-add 3 4)))])
             (lambda () (my-force promise))))
|#
; this way the thunk will be computed only one time
(my-mult 0 (let ([promise (my-delay (lambda () (slow-add 3 4)))])
             (lambda () (my-force promise))))

(my-mult 1 (let ([promise (my-delay (lambda () (slow-add 3 4)))])
             (lambda () (my-force promise))))

(my-mult 100 (let ([promise (my-delay (lambda () (slow-add 3 4)))])
             (lambda () (my-force promise))))