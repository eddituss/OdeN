
;; Árboles binarios
;; Se va a tomar la representación en preorden (R-I-D)
; Ejemplo:
(define arbol '(2
                (7
                 (3 () ())
                 (6
                  (8 () ())
                  (11 () ())))
                (5
                 ()
                 (9
                  (4 () ())
                  ()))))


;; Altura
;; Dominio: árboles binarios
;; Codominio: números de -1 a n
(define altura
  (lambda (arb)
    (cond ((null? arb) -1)
          (else
           (+ 1 (max (altura (cadr arb))
                     (altura (caddr arb))))))))


;; Cantidad de Nodos
;; Dominio: árboles binarios
;; Codominio: números naturales
(define cant-nodos
  (lambda (arb)
    (cond ((null? arb) 0)
          (else (+ 1 (cant-nodos (cadr arb)) (cant-nodos(caddr arb)))))))

;; Cantidad de Hojas
;; Dominio: árboles binarios
;; Codominio: números naturales
(define cant-hojas
  (lambda (arb)
    (cond ((null? arb) 0)
          ((es-hoja? arb) 1)
          (else (+ (cant-hojas (cadr arb)) (cant-hojas (caddr arb)))))))

(define es-hoja?
  (lambda (arb)
    (and (null? (cadr arb)) (null? (caddr arb)))))

;; Preorden R I D
;; Dominio: árboles binarios
;; Codominio: una lista en preorden
(define preorden
  (lambda (arb)
    (cond ((null? arb) arb)
          (else
           (cons (car arb)
                 (append (preorden (cadr arb))
                         (preorden (caddr arb))))))))

;; Inorden I R D
;; Dominio: árboles binarios
;; Codominio: una lista en inorden
(define inorden
  (lambda (arb)
    (cond ((null? arb) arb)
          (else
           (append (inorden (cadr arb))
                   (list (car arb))
                   (inorden (caddr arb)))))))

;; Postorden I D R
;; Dominio: árboles binarios
;; Codominio: una lista en postorden
(define postorden
  (lambda (arb)
    (cond ((null? arb) arb)
          (else
           (append (postorden (cadr arb))
                   (postorden (caddr arb))
                   (list (car arb)))))))

;; Generar árbol
;; Dominio: Dos listas que son el preorden y el inorden del árbol original
;; Codominio: árbol binario cuyo preorden e inorden son la preimagen

(define split
  (lambda (L e)
    (split-aux L e '())))

(define split-aux
  (lambda (L e Antes)
    (cond ((equal? (car L) e) (list (reverse Antes) (cdr L)))
          (else (split-aux (cdr L) e (cons (car L) Antes))))))

(define miembro?
  (lambda (L e)
    (cond ((null? L) #f)
          ((equal? (car L) e) #t)
          (else (miembro? (cdr L) e)))))

(define intersect
  (lambda (L1 L2)
    (apply append (map (lambda (x) (cond ((miembro? L2 x) (list x)) (else '()))) L1))))

(define resta
  (lambda (L1 L2)
    (apply append (map (lambda (x) (cond ((miembro? L2 x) '()) (else (list x)))) L1))))


(define genera-arb
  (lambda (pre in)
    (cond ((null? pre) '())
          (else
           (let* ((inParti (split in (car pre)))
                  (InIzq (car inParti))
                  (InDer (cadr inParti))
                  (PreIzq (intersect pre InIzq))
                  (PreDer (intersect pre InDer)))
             (list  (car pre)
                    (genera-arb PreIzq InIzq)
                    (genera-arb PreDer InDer)))))))

