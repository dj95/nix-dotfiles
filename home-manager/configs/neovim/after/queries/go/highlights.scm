;; extends
;; Keywords
(("return"   @keyword) (#set! conceal ""))
(("var"      @keyword) (#set! conceal "~"))
(("if"       @keyword.conditional) (#set! conceal "?"))
(("else"     @keyword.conditional) (#set! conceal "!"))
(("func"     @keyword.function) (#set! conceal "󰊕"))
(("for"      @keyword) (#set! conceal ""))
(("package"  @keyword.import) (#set! conceal "󰏗"))
(("import"   @keyword.import) (#set! conceal ""))
(("range"    @keyword) (#set! conceal "∈"))
