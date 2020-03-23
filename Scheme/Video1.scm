;; Dominio: Numeros reales
;; Codominio: Numeros reales (el cuadrado de la entrada)
(define cuad
  (lambda (x)
    (* x x)))

;; Dominio: Numeros reales
;; Codominio: Numeros reales (valor absoluto de la entrada)
(define val-abs
  (lambda (x)
    (cond ((>= x 0) x)
          (else (- x)))))

;; Dominio: Numeros naturales
;; Codominio: Naturales, pero que son factoriales de la entrada
(define fact
  (lambda (n)
    (cond ((zero? n) 1)
          (else (* n (fact (- n 1)))))))


;; Dominio: La tupla de un numero real y un natural
;; Codominio: Los numeros reales que son potencia de b
(define pow
  (lambda (b e)
    (cond ((zero? e) 1)
          ((even? e) (cuad (pow b (quotient e 2))))
          (else (* b (cuad (pow b (quotient e 2))))))))


;; Dominio: numeros naturales
;; Codominio: numeros naturales que son de Fibonacci
(define fibo
  (lambda (n)
    (cond ((zero? n) 0)
          ((= n 1) 1)
          (else (+ (fibo (- n 1)) (fibo (- n 2)))))))

;; Dominio: Numeros naturales
;; Codominio: Naturales, pero que son factoriales de la entrada
;; Implementado con recursion de cola
(define factorial
  (lambda (n)
    (fac n 1)))

(define fac
  (lambda (n acum)
    (cond ((zero? n) acum)
          (else (fac (- n 1) (* n acum))))))


;; Dominio: numeros naturales
;; Codominio: numeros naturales que son de Fibonacci
;; Implementado con recursion de cola
(define fibonacci
  (lambda (n)
    (fib n 1 0)))

(define fib
  (lambda (n fn fn-1)
    (cond ((= n 1) fn)
          (else (fib (- n 1) (+ fn fn-1) fn)))))
