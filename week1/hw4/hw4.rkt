
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; 1.
(define (sequence low high stride)
  (if (> low high)
      (list)
      (cons low (sequence (+ low stride) high stride))))

;;2.
(define (string-append-map xs string-suffix)
  (map (lambda (word) (string-append word string-suffix)) xs))

;;3.
(define (list-nth-mod xs n)
  (define i (remainder n (length xs)))
  (cond [(< n 0) (error "list-nth-mod: negative number")]
         [(null? xs) (error "list-nth-mod: empty list")]
         [#t (car (list-tail xs i))]))

;;4.
(define (stream-for-n-steps s n)
    (if (= n 0)
        null
        (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

;;5.
(define funny-number-stream
  (lambda ()
    (define (f n)
      (cons n (lambda () (f (if (= (remainder n 5) 4) (* (+ n 1) -1) (+ (abs n) 1))))))
    (f 1)))

;;6.
(define dan-then-dog
  (lambda ()
    (define (f n)
      (cons (if (= n 0) "dan.jpg" "dog.jpg") (lambda () (f (remainder (+ n 1) 2)))))
  (f 0)))

;;7.
(define (stream-add-zero stream)
  (lambda ()
  (let ([pr (stream)])
        (cons (cons 0 (car pr)) (stream-add-zero (cdr pr))))))

;;8.
(define (cycle-lists xs ys)
  (define (f x y)
    (cons (cons (list-nth-mod xs x) (list-nth-mod ys y)) (lambda () (f (+ x 1) (+ y 1)))))
  (lambda () (f 0 0)))

;;9.
(define (vector-assoc v vec)
  (define f (lambda (n)
  (cond [(= n (vector-length vec)) #f]
        [(not (pair? (vector-ref vec n))) (f (+ n 1))]
        [(= (car (vector-ref vec n)) v) (vector-ref vec n)]
        [#t (f (+ n 1))])
   ))
  (f 0)
)

;;10.
(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [lastAdd 0]
           [f (lambda (v)
                (let ([ans (vector-assoc v memo)])
                (if ans
                    ans
                    (let ([new-ans (assoc v xs)])
                    (begin
                           (vector-set! memo lastAdd new-ans)
                           ;(print memo)
                           (set! lastAdd (remainder (+ lastAdd 1) n))
                           new-ans)
))))])f))