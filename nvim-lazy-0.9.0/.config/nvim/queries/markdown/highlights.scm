;; extends

; Different captures for different heading levels
(atx_heading 
  (atx_h1_marker) 
  (inline) @text.h1)

(atx_heading 
  (atx_h2_marker) 
  (inline) @text.h2)

(atx_heading 
  (atx_h3_marker) 
  (inline) @text.h3)

(atx_heading 
  (atx_h4_marker) 
  (inline) @text.h4)

(atx_heading 
  (atx_h5_marker) 
  (inline) @text.h5)

(atx_heading 
  (atx_h6_marker) 
  (inline) @text.h6)

([
  (fenced_code_block)
]) @nospell
