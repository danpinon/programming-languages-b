#lang racket

(provide (all-defined-out))

(define (factorial-normal x)
  (if (= x 0)
      1
      (* x (factorial-normal (- x 1)))))

(factorial-normal 5) ; 120

(define (bad-if e1 e2 e3)
  (if e1 e2 e3)) ; this function evaluates all the expressions so if you pass a recursive call it will never end

(define (bad-factorial x) ; recursive function using bad-if
  (bad-if (= x 0)
          1
          (* x (factorial-normal (- x 1)))))

; (bad-factorial 0) -> infinite loop


; e2 and e3 should be a zero-argument functions (delayed evaluation)
(define (my-if-but-strange e1 e2 e3)
  (if e1 (e2) (e3))) ; (e)

(define (factorial-okay x)
  (my-if-but-strange (= x 0)
                    (lambda () 1) ; delayed evaluation
                    (lambda () (* x (factorial-normal (- x 1)))))) ; delayed evaluation

(factorial-okay 5) ; 120

#|
 THUNKS DELAY
 we know how to delay evaluation, put the expression in a function and call it later
 thanks to closures we can use same variables later
|#

;A zero-argument function used to delay evaluation is called THUNK; const addThunk = () => add(1,1); addThunk() -> 2
;as a verb: "thunk the expression"

#|
 KEY POINT
  - evaluate and expression e to get a result
                   e
 
 - a function that when called evaluates e and returns the result
   zero-argument function for "thunking"
                  (lambda () e)
 
 - evaluate e to some thunk and then evaluate the thunk, (call the thunk to get the result of the expression)
                   (e)

this idiom (thunks) help to avoid repeated or unnecessary computations

a thunk is the representation of a value and it can be get when the thunk is executed
|#