;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname LocalDemo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Local Demo
(local [s(define a 1)
        (define b 2)]
  (+ a b))
;; lexical scoping
(define p "incendio")  ; in global/top-level scope

(local [(define p "accio ")
        (define (fetch n) (string-append p n))]
  (fetch "portkey"))
 