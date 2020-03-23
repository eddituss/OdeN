;; Dominio: numeros reales
;; Codominio: cuadrados de numeros reales
(define cuad
  (lambda (x)
    (* x x)))

(define val-abs
  (lambda (x)
    (cond ((< x 0) (* x -1))
          (#t x))))

(define fact
  (lambda (n)
    (cond ((zero? n) 1) ; (= n 0)
          (else (* n (fact (- n 1)))))))


(define elevar
  (lambda (base ex)
    (cond ((zero? ex) 1)
          ((* base (elevar base (- ex 1)))))))

(define mipow
  (lambda (base ex)
    (cond ((zero? ex) 1)
          ((even? ex) (cuad (mipow base (quotient ex 2))))
          (#t (* base
                 (cuad (mipow base (quotient ex 2))))))))


(define fact-cola
  (lambda (n)
    (fact-cola-aux n 1)))

(define fact-cola-aux
  (lambda (n acum)
    (cond ((zero? n) acum)
          (#t (fact-cola-aux (- n 1) (* n acum))))))

(define fib
  (lambda (n)
    (fib-aux n 1 0)))

(define fib-aux
  (lambda (n fn fn-1)
    (cond ((= n 1) fn)
          (else (fib-aux (- n 1) (+ fn fn-1) fn)))))