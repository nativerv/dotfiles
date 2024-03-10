; extends

(
  (line_comment) @injection.language
  (_) @injection.content
  (line_comment) @_last 

  (#match? @_last "^/// ```$")
  (#offset! @injection.content 0 4 0 4)
  (#gsub! @injection.language "^/// ```(%w+)%s*$" "%1")
  (#gsub! @injection.language "^/// ```$" "rust")
  (#set! injection.combined)
)
