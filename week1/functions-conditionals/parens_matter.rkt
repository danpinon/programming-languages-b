#lang racket
(provide (all-defined-out))

(define (factorial n) (if (= n 0) 1 (* n (factorial (- n 1)))))