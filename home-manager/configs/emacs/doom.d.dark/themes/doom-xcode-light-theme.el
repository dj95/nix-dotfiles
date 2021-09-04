;;; doom-xcode-theme.el --- ibased off of Apple's Xcode Dark Theme -*- no-byte-compile: t; -*-
(require 'doom-themes)

(defgroup doom-xcode-light-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-xcode-light-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-xcode-light-theme
  :type '(choice integer boolean))

(def-doom-theme doom-xcode-light
  "A theme based off of the Xcode Light Theme"

  ;; name        gui       256       16
  ((bg         '("#ffffff" "#ffffff" nil          ))
   (bg-alt     '("#e0e0e0" "#e0e0e0" "black"      ))
   (base0      '("#b4d8fd" "#b4d8fd" "black"      ))
   (base1      '("#edf5ff" "#edf5ff"              ))
   (base2      '("#3e8087" "#3e8087"              ))
   (base3      '("#e0e0e0" "#e0e0e0" "brightblack"))
   (base4      '("#0f68a0" "#0f68a0" "brightblack"))
   (base5      '("#ad3da4" "#ad3da4" "brightblack"))
   (base6      '("#804fb8" "#804fb8" "brighblack"))
   (base7      '("#262626" "#262626" "brightblack"))
   (base8      '("#8a99a6" "#8a99a6" "white"      ))
   (fg         '("#262626" "#262626" "white"))
   (fg-alt     (doom-lighten fg 0.4))

   (red        '("#d22d1b" "#d22d1b" "red"))
   (orange     '("#de935f" "#de935f" "brightred"))
   (yellow     '("#f0c674" "#f0c674" "yellow"))
   (green      '("#b5bd68" "#b5bd68" "green"))
   (blue       '("#81a2be" "#81a2be" "brightblue"))
   (teal       '("#03638d" "#03638d" "brightblue")) ; FIXME replace with real teal
   (magenta    '("#c9b4cf" "#c9b4cf" "magenta"))
   (cyan       '("#8abeb7" "#8abeb7" "cyan"))
   (dark-cyan  (doom-darken cyan 0.4))


   (grey       '("#7a8590" "#7a8590" "brightblack"))
   (light-green'("#88c0b3" "#88c0b3" "lightgreen"))
   (violet     '("#4b21b1" "#4b21b1" "brightmagenta"))
   (light-blue '("#edf5ff" "#edf5ff" "lightblue"))
   (dark-blue  '("#e0e0e0" "#e0e0e0" "darkblue"))
   (number-blue '("#1c00cf" "#1c00cf" "darkblue"))
   (orange     '("#ef8775" "#ef8775" "orange"))
   (pink       '("#ef82af" "#ef82af" "pink"))

   ;; face categories
   (highlight      fg-alt)
   (vertical-bar   `("#161616" ,@base0))
   (selection      `(,(car light-blue) ,@(cdr fg-alt)))
   (builtin        light-green)
   (comments       grey)
   (doc-comments   (doom-lighten grey 0.14))
   (constants      number-blue)
   (functions      teal)
   (keywords       base5)
   (methods        base5)
   (operators      fg)
   (type           violet)
   (strings        red)
   (variables      teal)
   (numbers        number-blue)
   (region         selection)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    fg-alt)
   (vc-added       green)
   (vc-deleted     red)

   ;;;;; hl-fill-column-face
   ;; (hl-fill-column-face :background bg-alt :foreground fg-alt)

   ;; custom categories
   (modeline-bg     `(,(doom-darken (car bg-alt) 0.3) ,@(cdr fg-alt)))
   (modeline-bg-alt `(,(car bg) ,@(cdr fg)))
   (modeline-fg     fg)
   (modeline-fg-alt comments)
   (-modeline-pad
    (when doom-xcode-light-padded-modeline
      (if (integerp doom-xcode-light-padded-modeline)
          doom-xcode-light-padded-modeline
        4))))

  ;; --- faces ------------------------------
  ((doom-modeline-buffer-path       :foreground number-blue :bold bold)
   (doom-modeline-buffer-major-mode :inherit 'doom-modeline-buffer-path)

   ((line-number &override) :foreground fg-alt)
   ((line-number-current-line &override) :foreground fg :bold bold)

   ;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground violet)
   (rainbow-delimiters-depth-2-face :foreground blue)
   (rainbow-delimiters-depth-3-face :foreground orange)
   (rainbow-delimiters-depth-4-face :foreground green)
   (rainbow-delimiters-depth-5-face :foreground magenta)
   (rainbow-delimiters-depth-6-face :foreground yellow)
   (rainbow-delimiters-depth-7-face :foreground teal)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-alt :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt))))

  ;; --- extra faces ------------------------
  (
   (cursor            :background fg-alt)
   (lazy-highlight    :background bg-alt  :foreground base8 :distant-foreground base0 :weight 'bold)
   (isearch           :foreground "black" :background orange)
   (isearch-fail      :foreground fg :background red)

   (hl-line             :background yellow)
   (hl-fill-column-face :background light-blue :foreground fg-alt)

   ;; company-mode
   (company-scrollbar-bg                      :background base1)
   (company-scrollbar-fg                      :background bg-alt)
   (company-tooltip                           :background bg-alt)
   (company-tooltip-annotation                :foreground green)
   (company-tooltip-annotation-selection      :inherit 'company-tooltip-annotation)
   (company-tooltip-selection                 :foreground violet :background base2)
   (company-tooltip-common                    :foreground blue :underline t)
   (company-tooltip-common-selection          :foreground blue :underline t)
   (company-preview-common                    :foreground base7)
   (company-preview                           :background lightblue4)
   (company-preview-search                    :background turquoise4)
   (company-template-field                    :foreground "black" :background yellow)
   (company-echo-common                       :foreground faded-red)

   ;; flycheck
   (flycheck-info :underline `(:style wave :color ,blue))

   ;; ivy
   (ivy-current-match :background yellow :distant-foreground base0)
   (ivy-minibuffer-match-face-1     :foreground orange)
   (ivy-minibuffer-match-face-2     :foreground yellow)
   (ivy-minibuffer-match-face-3     :foreground faded-orange)
   (ivy-minibuffer-match-face-4     :foreground faded-yellow)

   ;; posframe
   (ivy-posframe               :background bg-alt)

   ;; --- lsp --------------------------
   (lsp-ui-doc-background :background bg-alt)
   (lsp-face-highlight-read    :background (doom-blend bg orange 0.5))
   (lsp-face-highlight-textual :inherit 'lsp-face-highlight-read)
   (lsp-face-highlight-write   :inherit 'lsp-face-highlight-read)

   ;; popup
   (popup-face :foreground base6  :background base1)
   (popup-menu-selection-face :foreground fg :background green)
   (popup-menu-mouse-face :foreground fg :background green)
   (popup-tip-face :foreground base5 :background base2)

   ;; tooltip
   (tooltip :background base1 :foreground base6)

   ;; whitespace
   (whitespace-trailing :foreground red :background base1)
   (whitespace-line :foreground red :background base1)
   (whitespace-indentation :foreground base4 :background bg)
   (whitespace-empty :foreground 'nil :background 'nil)
  )

  ;; --- variables --------------------------
  ;; ()
  )

(provide 'doom-xcode-light-theme)
;;; doom-xcode-theme.el ends heret
