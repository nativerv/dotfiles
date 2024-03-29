;; extends

; Different captures for different heading levels
(atx_heading 
  (atx_h1_marker) @markup.heading.1.delimiter 
  (inline) @markup.heading.1)

(atx_heading 
  (atx_h2_marker) @markup.heading.2.delimiter 
  (inline) @markup.heading.2)

(atx_heading 
  (atx_h3_marker) @markup.heading.3.delimiter 
  (inline) @markup.heading.3)

(atx_heading 
  (atx_h4_marker) @markup.heading.4.delimiter 
  (inline) @markup.heading.4)

(atx_heading 
  (atx_h5_marker) @markup.heading.5.delimiter 
  (inline) @markup.heading.5)

(atx_heading 
  (atx_h6_marker) @markup.heading.6.delimiter 
  (inline) @markup.heading.6)

([
  (fenced_code_block)
]) @nospell

; NOTE: The following has been commented out due to issues with spaces in the
; list marker nodes generated by the parser. If those spaces ever get captured
; by a different node (e.g. block_continuation) we can safely re-add these
; conceals.
;; Conceal bullet points
; ([(list_marker_plus) (list_marker_star)]
;   @punctuation.special
;   (#offset! @punctuation.special 0 0 0 -1)
;   (#set! conceal "•"))
; ([(list_marker_plus) (list_marker_star)]
;   @punctuation.special
;   (#any-of? @punctuation.special "+" "*")
;   (#set! conceal "•"))
; ((list_marker_minus)
;   @punctuation.special
;   (#offset! @punctuation.special 0 0 0 -1)
;   (#set! conceal "—"))
; ((list_marker_minus)
;   @punctuation.special
;   (#eq? @punctuation.special "-")
;   (#set! conceal "—"))
