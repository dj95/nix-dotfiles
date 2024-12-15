;; extends
;; Keywords
(("return"   @keyword) (#set! conceal ""))
(("let"      @keyword) (#set! conceal "~"))
(("if"       @keyword.conditional) (#set! conceal "?"))
(("match"    @keyword.conditional) (#set! conceal "?"))
(("else"     @keyword.conditional) (#set! conceal "!"))
(("fn"       @keyword.function) (#set! conceal "󰊕"))
(("for"      @keyword) (#set! conceal ""))
(("while"    @keyword) (#set! conceal ""))
(("use"      @keyword.import) (#set! conceal "󰏗"))
(("//"       @comment) (#set! conceal "│"))
