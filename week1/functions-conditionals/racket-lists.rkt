#lang racket
(provide (all-defined-out))

;list processing: null, cons, null?, car, cdr
; we won't use pattern matching in Racket

; sum all the numbers in a list
(define (sum xs)
  (if (null? xs)
      0
      (+ (sum (cdr xs)) (car xs))))

; append
(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))

;map
(define (my-map xs cb)
  (if (null? xs)
      null
      (cons (cb (car xs)) (my-map (cdr xs) cb))))
