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

