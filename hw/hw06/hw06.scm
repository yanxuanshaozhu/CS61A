(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cdr (cdr s)))
)


(define (sign num)
  (cond ((> num 0) 1) ((zero? num) 0) ((< num 0) -1))
)


(define (square x) (* x x))

(define (pow x y)

	(if (= y 0) 1 
		(if (even? y) (square (pow x (/ y 2))) 
			(if (odd? y)  (* x (pow x (- y 1))))
		)
	)
)
