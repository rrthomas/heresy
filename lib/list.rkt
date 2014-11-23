#lang s-exp "../private/base.rkt"

(require "math.rkt")
(provide (all-defined-out))

; (map *fun* *lst*)
; Takes a single-argument function and list,
; returning a new list with the function applied to each entry.
(def fn map (fun lst)
  (select
   ((null? lst) lst)
   (else (join (fun (head lst))
               (map fun (tail lst))))))

; (filter *pred* *lst*)
; Returns a new list, containing only those items which are True according to pred
(def fn filter (pred lst)
  (select
   ((null? lst) lst)
   ((pred (head lst))
    (join (head lst)
          (filter pred (tail lst))))
    (else (filter pred (tail lst)))))

; (len *lst*)
; Returns the number of items in the list
(def fn len (lst)
  (select
   ((null? lst) 0)
   (else (+ 1 (len (tail lst))))))

; (foldr *fun* *base* *lst*)
; Folds a list from the right, combining pairs with fun, and returns the result
(def fn foldr (fun base lst)
  (select
   ((null? lst) base)
   (else (fun (head lst) (foldr fun base (tail lst))))))

; (foldl *fun* *base* *lst*)
; Folds a list from the left
(def fn foldl (fun base lst)
  (select
   ((null? lst) base)
   (else (foldl fun (fun (head lst) base) (tail lst)))))

; (reverse *lst*)
; Returns list with items in reverse order
(def fn reverse (lst)
  (foldl join Null lst))

; (index *nth* *lst*)
; Returns the nth entry in lst
(def fn index (nth lst)
  (select
   ((> nth (len lst)) (error 'index "out of index"))
   ((one? nth) (head lst))
   (else (index (- nth 1) (tail lst)))))

; (inlst *lst* *item*)
; Searches lst for item, returns index of item if found, False if not
(def fn inlst (lst item (idx 1))
  (select
   ((null? lst) False)
   ((eq? (head lst) item) idx)
   (else (inlst (tail lst) item (+ 1 idx)))))