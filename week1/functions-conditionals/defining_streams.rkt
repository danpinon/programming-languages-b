#lang racket
(provide (all-defined-out))
; 1 1 1 1 1 1 1 ...

(define ones (lambda () (cons 1 ones)))

; 1 2 3 4 5 6 7 ...
(define (f x) (cons x (lambda () (f (+ x 1)))))
(define nats (lambda () (f 1)))

(define nats2
  (lambda ()
    (define (f x) (cons x (lambda () (f (+ x 1)))))
    (f 1)))

(define nats3
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
  (lambda () (f 1))))

; 2 4 8 16 32 64 ...
(define powers-of-two
  (lambda ()
    (define (f x) (cons x (lambda () (f (* x 2)))))
    (f 1)))