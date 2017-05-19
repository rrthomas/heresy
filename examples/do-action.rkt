#lang heresy

(describe Identity (state Null))

(def fn id (v)
  (Identity (list v)))

(def fn >>= (act fn)
  (fn (act 'state)))

(def macroset do> (:=)
  ((_ (exp ...)) (exp ...))
  ((_ (name := val) exp ...)
   (>>= (id val) (fn (name) (do> exp ...))))
  ((_ (exp0 ...) exp1 ...)
   (>>= (id (exp0 ...)) (fn (_) (do> exp1 ...)))))

(do>
 (a := (input stx))
 (b := (input stx))
 (print (format$ "#_ * #_ = " a b))
 (c := (* a b))
 (a := 100)
 (print c))