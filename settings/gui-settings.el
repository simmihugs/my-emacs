(defalias 'yes-or-no-p 'y-or-n-p)

(global-hl-line-mode +1)

(tool-bar-mode 0)

(menu-bar-mode 0)

(scroll-bar-mode -1)

(setq scroll-preserve-screen-position 1)
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))
(setq scroll-step            1
      scroll-conservatively  10000)

(setq inhibit-startup-screen 1)

;;(set-frame-font "Fira Code 12" nil t)
;;(set-frame-font "Cascadia Code 12" nil t)

(custom-set-faces
 '(info-xref                                ((t (:foreground "#27d96e"))))
 '(nobreak-space                            ((t (:foreground "#27d96e"))))
 '(package                                  ((t (:foreground "#27d96e"))))
 '(link                                     ((t (:foreground "#27d96e"))))
 '(font-lock-doc-face                       ((t (:foreground "#fcba03"))))
 '(font-lock-builtin-face                   ((t (:foreground "yellow green"))))
 '(font-lock-comment-face                   ((t (:foreground "#ffa500"))))
 '(font-lock-negation-char-face             ((t (:foreground "#27d96e"))))
 '(font-lock-reference-face                 ((t (:foreground "#27d96e"))))
 '(font-lock-constant-face                  ((t (:foreground "#27d96e"))))
 '(font-lock-function-name-face             ((t (:foreground "yellow" :bold nil))))
 '(font-lock-keyword-face                   ((t (:bold nil :foreground "yellow"))))
 '(font-lock-string-face                    ((t (:foreground "#bd8a00"))))
 '(font-lock-type-face                      ((t (:foreground "#228b22" ))))
 '(font-lock-variable-name-face             ((t (:foreground "green"))))
 '(font-lock-warning-face                   ((t (:foreground "red" ))))
 '(font-lock-regexp-grouping-backslash      ((t (:foreground "#d9d327"))))
 '(font-lock-regexp-grouping-construct      ((t (:foreground "#d9d327"))))
 '(font-lock-preprocessor-face              ((t (:foreground "yellow green"))))
 '(haskell-constructor-face                 ((t (:inherit font-lock-type-face :foreground "#228b22"))))
 '(lsp-lens-mouse-face                      ((t (:inherit font-lock-type-face :foreground "#27d96e")))) 
 '(haskell-definition-face                  ((t (:inherit font-lock-function-name-face :foreground "green"))))
 '(haskell-error-face                       ((t (:inherit font-lock-type-face :foreground "red"))))
 '(haskell-interactive-face-compile-error   ((t (:inherit font-lock-string-face :foreground "red"))))
 '(haskell-interactive-face-compile-warning ((t (:inherit font-lock-string-face :foreground "orange"))))
 '(haskell-interactive-face-garbage         ((t (:inherit font-lock-string-face :foreground "yellow"))))
 '(haskell-interactive-face-prompt          ((t (:inherit font-lock-string-face :foreground "yellow green"))))
 '(haskell-interactive-face-prompt-cont     ((t (:inherit font-lock-string-face :foreground "#ff0000"))))
 '(haskell-interactive-face-result          ((t (:inherit font-lock-string-face :foreground "#ffffff"))))
 '(haskell-keyword-face                     ((t (:inherit font-lock-keyword-face :foreground "yellow green"))))
 '(haskell-literate-comment-face            ((t (:inherit font-lock-string-face :foreground "blue"))))
 '(haskell-operator-face                    ((t (:inherit font-lock-string-face :foreground "yellow"))))
 '(haskell-pragma-face                      ((t (:inherit font-lock-string-face :foreground "#ffa500"))))
 '(haskell-quasi-quote-face                 ((t (:inherit font-lock-string-face :foreground "brightred"))))
 '(help-key-binding                         ((t (:background "gray12" :foreground "sky blue"))))
 '(hl-line                                  ((t (:underline "yellow"))))
 '(highlight                                ((t (:inherit dired nil
						 :background 'unspecified
						 :foreground 'unspecified))))
 '(default                                  ((t (:inherit nil
						 :foreground "white"
						 :background "#383838"
						 :stipple nil
						 :inverse-video nil
						 :box nil
						 :strike-through nil
						 :overline nil
						 :underline nil
						 :weight normal
						 :font "Cascadia Code"
						 :width normal))))
 '(biblio-highlight-extend-face             ((t (:inherit default :extend t))))
 '(cursor                                   ((t (:background "#ff2200" :height 3.0))))
 '(font-lock-string-face                    ((t (:foreground "orange"))))
 '(header-line-highlight                    ((t (:inherit nil :background "dim gray"))))
 '(line-number-current-line                 ((t (:inherit line-number :foreground "cyan" :background "#1b0075"))))
 '(minibuffer-prompt                        ((t (:foreground "cyan"))))
 '(org-agenda-date                          ((t (:inherit org-agenda-structure :foreground "brightblue"))))
 '(org-agenda-structure                     ((t (:foreground "cyan"))))
 '(org-document-info                        ((t (:foreground "cyan"))))
 '(org-document-title                       ((t (:foreground "deep sky blue"))))
 '(org-level-1                              ((t (:foreground "orange red"))))
 '(org-level-2                              ((t (:foreground "forest green"))))
 '(rainbow-delimiters-depth-1-face          ((t (:inherit rainbow-delimiters-base-face :foreground "#DB0077"))))
 '(rainbow-delimiters-depth-2-face          ((t (:inherit rainbow-delimiters-base-face :foreground "#0052CC"))))
 '(rainbow-delimiters-depth-3-face          ((t (:inherit rainbow-delimiters-base-face :foreground "#EE7600"))))
 '(rainbow-delimiters-depth-4-face          ((t (:inherit rainbow-delimiters-base-face :foreground "#00753B"))))
 '(rainbow-delimiters-depth-5-face          ((t (:inherit rainbow-delimiters-base-face :foreground "#ff2200"))))
 '(rainbow-delimiters-depth-6-face          ((t (:inherit rainbow-delimiters-base-face :foreground "#fbff00")))))

(custom-set-variables
 '(cursor-type '(hbar . 4))
 '(display-line-numbers 'absolute)
 '(horizontal-scroll-bar-mode nil))
