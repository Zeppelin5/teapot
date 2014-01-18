#lang racket/gui

;File format[edit] http://en.wikipedia.org/wiki/Wavefront_.obj_file
; http://isg.cs.tcd.ie/spheretree/models/teapot.obj
;Lines beginning with a hash character (#) are comments.
;# this is a comment
;An OBJ file contains several types of definitions:
;# List of Vertices, with (x,y,z[,w]) coordinates, w is optional and defaults to 1.0.
;  v 0.123 0.234 0.345 1.0
;  v ...
;  ...
;  # Texture coordinates, in (u ,v [,w]) coordinates, these will vary between 0 and 1, w is optional and default to 0.
;  vt 0.500 1 [0]
;  vt ...
;  ...
;  # Normals in (x,y,z) form; normals might not be unit.
;.
;  vn 0.707 0.000 0.707
;  vn ...
;  ...
;  # Parameter space vertices in ( u [,v] [,w] ) form; free form geometry statement ( see below )
;  vp 0.310000 3.210000 2.100000
;  vp ...
;  ...
;  # Face Definitions (see below)
;  f 1 2 3
;  f 3/1 4/2 5/3
;  f 6/4/1 3/5/3 7/6/5
;  f ...
;  ...

(struct obj (vertices texture-vertices  vertex-normals faces))
(struct vertice (x y z))

;; obj-load ; filename -> list
(define (obj-load filename)
  (let* ((input-port (open-input-file filename))
         (doc (port->lines input-port)))
    doc))

(define (remove-comments list-of-strings)
  (define (is-not-comment-line? line)
    (if (or (= (string-length line) 0)
            (equal? (string-ref line 0) #\#))
        #f #t))
  (filter is-not-comment-line? list-of-strings))

(define teapot-list (obj-load "teapot.obj"))

(remove-comments teapot-list)
