;; extends
;; Keywords
(("return"     @keyword) (#set! conceal ""))
(("if"         @keyword) (#set! conceal "?"))
(("else"       @keyword) (#set! conceal "!"))
(("function"   @keyword) (#set! conceal "𝝺"))
(("for"        @keyword) (#set! conceal ""))
(("foreach"    @keyword) (#set! conceal "∀"))
(("public"     @keyword) (#set! conceal "⊕"))
(("protected"  @keyword) (#set! conceal "⊖"))
(("private"    @keyword) (#set! conceal "⊗"))
(("use"        @keyword) (#set! conceal "∈"))
(("class"      @keyword) (#set! conceal ""))
(("namespace"  @keyword) (#set! conceal "⊂"))
(("implements" @keyword) (#set! conceal "⊆"))
(("new"        @keyword) (#set! conceal "∃"))
(("as"         @keyword) (#set! conceal "≔"))
(((php_tag)    @tag)     (#set! conceal "—"))