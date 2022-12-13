;; extends

;; enable actual strikethrough of `~text~`
(strikethrough) @text.strike

;; conceal bold and italics
((emphasis_delimiter) @conceal (#set! conceal ""))

;; bruh, don't remember why it's here
(link_text) @text.uri

([
  (code_span_delimiter)
] @conceal @text.literal
(#set! conceal " ")
)
