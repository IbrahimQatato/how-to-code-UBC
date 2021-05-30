;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Flowers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; A growing flower animation that starts at the position of mouse click

;; =================
;; Constants:
(define WIDTH 600)
(define HEIGHT 400)
(define MTS (empty-scene WIDTH HEIGHT))
(define SCALE-FACTOR 3)
(define  PETAL(put-pinhole
                1 1
                (ellipse 4 2 "solid" "purple")))
(define FLOWER
    (clear-pinhole
     (overlay/pinhole
      (circle 1 "solid" "yellow")
      (rotate (* 60 0)  PETAL)
      (rotate (* 60 1)  PETAL)
      (rotate (* 60 2)  PETAL)
      (rotate (* 60 3)  PETAL)
      (rotate (* 60 4)  PETAL)
      (rotate (* 60 5)  PETAL))))
;; =================
;; Data definitions:
(define-struct flower (x y s))
;; Flower is (Natural Natural Natural[1,infinity) )
;; interp. used to represent a flower image where:
;;       - x is the x coordinate
;;       - y is the y coordinate
;;       - s is the scale factor
(define f1 (make-flower 0 0 1))
(define f2 (make-flower 20 50 3))
#;
(define (fn-for-flower f)
  (... (flower-x f)      ;Natural
       (flower-y f)      ;Natural
       (flower-s f)))    ;Natural
;; Template rules used:
;;  - compound: 3 fields

;; =================
;; Functions:

;; Flower -> Flower
;; start the world with (main (make-flower 9999 9999 1)
;; 
(define (main fl)
  (big-bang fl                   ; Flower
            (on-tick   grow)     ; Flower -> Flower
            (to-draw   render)   ; Flower -> Image
            (on-mouse  new-flower) ))     ; Flower Integer Integer MouseEvent -> Flower

;; Flower -> Flower
;; increment scale factor by SCALE-RATE
(check-expect (grow (make-flower 0 0 1)) (make-flower 0 0 (+ 1 SCALE-FACTOR)))
;(define (grow fl) (make-flower 0 0 1));stub
;;<used template from Flower>
(define (grow f)
  (make-flower (flower-x f)      
       (flower-y f)      
       (+ SCALE-FACTOR (flower-s f))))    

;; Flower -> Image
;; render the FLOWER image at the appropriate position scaled up by SCALE-FACTOR
(check-expect (render (make-flower 0 0 1)) (place-image (scale 1 FLOWER) 0 0 MTS))
(check-expect (render (make-flower 50 75 10)) (place-image (scale 10 FLOWER) 50 75 MTS))
;(define (render fl) MTS);stub
;;<used template from Flower>
(define (render f)
  (place-image(scale (flower-s f) FLOWER)
              (flower-x f)      
              (flower-y f)
              MTS))   
;; Flower Integer Integer MouseEvent -> Flower
;; start a new flower animation centered at (x, y)
(check-expect (new-flower (make-flower 0 0 1) 50 75 "button-down")
              (make-flower 50 75 1))
(check-expect (new-flower (make-flower 0 0 1) 50 75 "drag")
              (make-flower 0 0 1))
;(define (new-flower fl x y me) (make-flower 0 0 1));stub
(define (new-flower fl x y me)
  (cond [(mouse=? me "button-down") (make-flower x y 1)]
        [else fl]))