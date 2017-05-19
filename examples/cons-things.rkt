#lang heresy

(import rkt racket/base)

(describe Cons
          (car Null)
          (cdr Null))

(def fn cons (a b)
  (Cons (list a b)))

(def fn car (l)
  (l 'car))

(def fn cdr (l)
  (l 'cdr))

(def fn cons? (v)
  (is-a? Cons v))

(def fn print-cons (l)
  (select
   ((null? l) "Null")
   ((cons? (car l)) (format$ "Cons(#_, #_)" (print-cons (car l)) (print-cons (cdr l))))
   (else (format$ "Cons(#_, #_)" (car l) (print-cons (cdr l))))))

(def fn cons->list (l)
  (select
   ((null? l) l)
   ((cons? (car l)) (join (cons->list (car l))
                        (cons->list (cdr l))))
   (else (join (car l)
               (cons->list (cdr l))))))

(def l (cons 1 (cons (cons 2 (cons 4 Null)) (cons 3 Null))))

(print-cons l)
(cons->list l)
(cons? l)