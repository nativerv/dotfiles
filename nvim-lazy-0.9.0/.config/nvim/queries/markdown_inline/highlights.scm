;; extends

;; enable actual strikethrough of `~text~`
(strikethrough) @htmlStrike

;; conceal bold and italics
((emphasis_delimiter) @conceal (#set! conceal ""))

;; bruh, don't remember why it's here
(link_text) @text.uri

([
  (code_span_delimiter)
] @conceal @text.literal
(#set! conceal "")
)

([
  (uri_autolink)
  (link_destination)
  (code_span)
]) @nospell

; disable spelling check in tag links
(
  "#"
  .
  (inline_link
    (link_text) @nospell
  )
)

; (tag_name (attribute) @nospell) @nospell

; todos/notes/etc

; ; ((tag
; ;   (name) @text.todo @nospell
; ;   ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
; ;   ":" @punctuation.delimiter)
; ;   (#eq? @text.todo "TODO"))
;
; ((_) @text.todo @nospell
;  (#eq? @text.todo "TODO"))
;
; ; ((tag
; ;   (name) @text.note @nospell
; ;   ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
; ;   ":" @punctuation.delimiter)
; ;   (#any-of? @text.note "NOTE" "XXX"))
;
; ((_) @text.note @nospell
;  (#any-of? @text.note "NOTE" "XXX"))
;
; ; ((tag
; ;   (name) @text.warning @nospell
; ;   ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
; ;   ":" @punctuation.delimiter)
; ;   (#any-of? @text.warning "HACK" "WARNING" "SAFETY"))
;
; ((_) @text.warning @nospell
;  (#any-of? @text.warning "HACK" "WARNING" "SAFETY"))
;
; ; ((tag
; ;   (name) @text.danger @nospell
; ;   ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
; ;   ":" @punctuation.delimiter)
; ;   (#any-of? @text.danger "FIXME" "BUG" "DANGER"))
;
; ((_) @text.danger @nospell
;  (#any-of? @text.danger "FIXME" "BUG" "DANGER"))
;
; ; Issue number (#123)
; ((_) @number
;  (#lua-match? @number "^#[0-9]+$"))
;
; ; User mention (@user)
; ((_) @constant @nospell
;  (#lua-match? @constant "^[@][a-zA-Z0-9_-]+$")
;  (#set! "priority" 95))
