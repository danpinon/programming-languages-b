#lang racket
(provide (all-defined-out))
; A stream is an INFINITE sequence of values
#|
   It is to represent the KEY IDEA of something that could go forever.
   the Key Idea is to use a thunk to delay the evaluation of most of the sequence.
   Just a programming idiom
|#

#|
  A powerful concept for division labor:
   - Stream producer knows how to create any number of values
   - Stream consumer decides how many values to ask for
|#

;example with powers-of-two
; one of the streams is the sequence of powers of two
; 1 2 4 8 16 32
; you don't know how many powers of two you will need
;; powers-of-two ; a procedure
;; (powers-of-two) ;;-> (2 . <procedure>)
;; (car (powers-of-two)) ;;-> 2
;; (car ((cdr (powers-of-two)))) ;;-> 4
;; (car ((cdr ((cdr (powers-of-two)))))) ;;-> 8

(define (number-until stream tester)
  (letrec ([f (lambda (stream ans)      ;; let f = (stream, ans) => {...}
             (let ([pair (stream)])     ;; execute the stream to get the pair ;; `let pair = stream();`
               (if (tester (car(pair))) ;; if test true return ans ;; `if ( test(pair[0]) )`
                   ans                  ;; returns the number of times called
                   (f (cdr pair) (+ ans 1)))))]) ;; else call again f with the next pair and with ans + 1 ;; `f(pair[1], ans + 1);`
    (f stream 1)))                      ;; `return f(stream, 1);`

#| in JS
const number-until = (stream, tester) => {
  let f = (stream, ans) => {
     let [value, nextStream] = stream(); // or let pair = stream();
     if ( tester(value) ) return ans;
     return f(nextStream, ans + 1);
  }
  return f(stream, 1);
}
|#

;execution
;(number-until powers-of-two (lambda (value) (= value 16))) -> 4 times
;(number-until powers-of-two (lambda (value) (> value 33))) -> 8 times
  
  