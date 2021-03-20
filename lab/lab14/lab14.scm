(define (split-at lst n)
  (cond 
    ((null? lst) (cons nil nil))
    ((= 0 n) (cons nil lst))
    (else (cons (cons (car lst) (car (split-at (cdr lst) (- n 1)))) (cdr (split-at (cdr lst) (- n 1)))))
  )
)



(define (compose-all funcs)
  (lambda (n)
    (cond 
      ((null? funcs) n)
      (else ((compose-all (cdr funcs)) ((car funcs) n)))
      
    )
  )
)

