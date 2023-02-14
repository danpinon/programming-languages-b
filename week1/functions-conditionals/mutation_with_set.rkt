#lang racket

; General principle: if something you need not to change might change, make a local copy of it. Example:

(define b 3)

(define f
  (let ([b b])
    (lambda (x) (* 1 (+ x b)))))

(set! b 40) ;mutates b, but f content will remain the same

(define w f); saves the original b = 3 value

