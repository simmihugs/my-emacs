;; Load settings
(mapc #'(lambda (s)
          (org-babel-load-file
           (expand-file-name
            (concat "settings/" s ".org")
            user-emacs-directory)))
      '("gui-settings"
	"package-setup"
	"default-settings"))

;; Load packages
(mapc #'(lambda (s)
          (org-babel-load-file
           (expand-file-name
            (concat "packages/" s ".org")
            user-emacs-directory)))
      '("package-minions/package-minions"
	"package-smartparens/package-smartparens"
	"package-all-the-icons/package-all-the-icons"
	"package-rainbow/package-rainbow"
	"package-visual-regex/package-visual-regex"
	"package-org/package-org"
	"package-dired-sidebar/package-dired-sidebar"
	"package-show-paren/show-paren"
	"package-ace/ace"
	"package-eshell/eshell"
	"package-yasnippet/yasnippet"
	"package-company/company"
	"package-ccls/ccls"
	"package-yaml/yaml"
	"package-rust/package-rust"
	"package-vala/vala"
	))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor-type '(hbar . 4))
 '(display-line-numbers 'absolute)
 '(horizontal-scroll-bar-mode nil)
 '(package-selected-packages
   '(company-tern tern elm-mode rjsx-mode vue-mode typoscript-mode twig-mode json-mode js2-refactor indium yaml-mode web-mode lsp-typescript prettier-js typescript-mode meson-mode meson vala-mode vala rust-mode rust exwm ccls lsp-ui lsp-mode yasnippet eshell-toggle ace-window visual-regexp rainbow-mode rainbow-delimiters org-drill org-ref org-wild-notifier alert ox-reveal all-the-icons smartparens minions use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :foreground "white" :background "#383838" :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :weight normal :font "Cascadia Code" :width normal))))
 '(all-the-icons-dired-dir-face ((t (:foreground "#c9be7f"))))
 '(biblio-highlight-extend-face ((t (:inherit default :extend t))))
 '(cursor ((t (:background "#ff2200" :height 3.0))))
 '(font-lock-builtin-face ((t (:foreground "yellow green"))))
 '(font-lock-comment-face ((t (:foreground "#ffa500"))))
 '(font-lock-constant-face ((t (:foreground "#27d96e"))))
 '(font-lock-doc-face ((t (:foreground "#fcba03"))))
 '(font-lock-function-name-face ((t (:foreground "yellow" :bold nil))))
 '(font-lock-keyword-face ((t (:bold nil :foreground "yellow"))))
 '(font-lock-negation-char-face ((t (:foreground "#27d96e"))))
 '(font-lock-preprocessor-face ((t (:foreground "yellow green"))))
 '(font-lock-reference-face ((t (:foreground "#27d96e"))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#d9d327"))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "#d9d327"))))
 '(font-lock-string-face ((t (:foreground "#bd8a00"))))
 '(font-lock-type-face ((t (:foreground "#228b22"))))
 '(font-lock-variable-name-face ((t (:foreground "green"))))
 '(font-lock-warning-face ((t (:foreground "red"))))
 '(haskell-constructor-face ((t (:inherit font-lock-type-face :foreground "#228b22"))))
 '(haskell-definition-face ((t (:inherit font-lock-function-name-face :foreground "green"))))
 '(haskell-error-face ((t (:inherit font-lock-type-face :foreground "red"))))
 '(haskell-interactive-face-compile-error ((t (:inherit font-lock-string-face :foreground "red"))))
 '(haskell-interactive-face-compile-warning ((t (:inherit font-lock-string-face :foreground "orange"))))
 '(haskell-interactive-face-garbage ((t (:inherit font-lock-string-face :foreground "yellow"))))
 '(haskell-interactive-face-prompt ((t (:inherit font-lock-string-face :foreground "yellow green"))))
 '(haskell-interactive-face-prompt-cont ((t (:inherit font-lock-string-face :foreground "#ff0000"))))
 '(haskell-interactive-face-result ((t (:inherit font-lock-string-face :foreground "#ffffff"))))
 '(haskell-keyword-face ((t (:inherit font-lock-keyword-face :foreground "yellow green"))))
 '(haskell-literate-comment-face ((t (:inherit font-lock-string-face :foreground "blue"))))
 '(haskell-operator-face ((t (:inherit font-lock-string-face :foreground "yellow"))))
 '(haskell-pragma-face ((t (:inherit font-lock-string-face :foreground "#ffa500"))))
 '(haskell-quasi-quote-face ((t (:inherit font-lock-string-face :foreground "brightred"))))
 '(header-line-highlight ((t (:inherit nil :background "dim gray"))))
 '(help-key-binding ((t (:background "gray12" :foreground "sky blue"))))
 '(highlight ((t (:inherit dired nil :background 'unspecified :foreground 'unspecified))))
 '(hl-line ((t (:underline "yellow"))))
 '(info-xref ((t (:foreground "#27d96e"))))
 '(line-number-current-line ((t (:inherit line-number :foreground "cyan" :background "#1b0075"))))
 '(link ((t (:foreground "#27d96e"))))
 '(lsp-lens-mouse-face ((t (:inherit font-lock-type-face :foreground "#27d96e"))))
 '(minibuffer-prompt ((t (:foreground "cyan"))))
 '(nobreak-space ((t (:foreground "#27d96e"))))
 '(org-agenda-date ((t (:inherit org-agenda-structure :foreground "brightblue"))))
 '(org-agenda-structure ((t (:foreground "cyan"))))
 '(org-document-info ((t (:foreground "cyan"))))
 '(org-document-title ((t (:foreground "deep sky blue"))))
 '(org-level-1 ((t (:foreground "orange red"))))
 '(org-level-2 ((t (:foreground "forest green"))))
 '(package ((t (:foreground "#27d96e"))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "#DB0077"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "#0052CC"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "#EE7600"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "#00753B"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "#ff2200"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "#fbff00")))))
