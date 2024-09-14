(use-package lsp-mode
  :straight t
  :init
  :hook ((python-mode     . lsp-deferred)
	 (c-mode          . lsp-deferred)
	 ;;(js-mode         . lsp-deferred)
	 ;;(typescript-mode . lsp-deferred)
	 (html-mode       . lsp-deferred)
	 (css-mode        . lsp-deferred)
	 (rust-mode       . lsp-deferred)
         (lsp-mode        . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :bind (("C-c C-f" . lsp-format-buffer)
         ("C-l" . lsp-find-definition))
  :config
  (setq lsp-clients-clangd-args
	'("--header-insertion=never")))

(use-package typescript-mode
  :straight t)

(use-package lsp-ui
  :straight t
  :commands (lsp-ui-mode)
  :custom
  ;; Sideline
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-show-code-actions nil)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-delay 0)
  ;; Peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory nil)
  ;; Documentation
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-delay 0.2)
  ;; IMenu
  (lsp-ui-imenu-window-width 0)
  (lsp-ui-imenu--custom-mode-line-format nil)
  :hook (lsp-mode . lsp-ui-mode))

;; rust
(use-package rust-mode
  :straight t
   :config
  (require 'rust-rustfmt)
  (require 'lsp-rust)
  (setq rust-format-on-save t))

;; javascript
(use-package js2-mode
  :straight t
  :config
  (setq-default js2-basic-offset 2)
  (setq-default indent-tabs-mode nil))

;; haskell
(use-package lsp-haskell
  :straight t)

(use-package haskell-mode
  :straight t
  :hook (haskell-mode . lsp-deferred)
  :bind ("C-l" . haskell-interactive-mode-clear))

;; lean4
(use-package lean4-mode
  :straight (lean4-mode
	     :type git
	     :host github
	     :repo "leanprover/lean4-mode"
	     :files ("*.el" "data"))
  ;; to defer loading the package until required
  :commands (lean4-mode))

;; c++
(use-package cc-mode
  :straight nil
  :config
  (c-add-style "microsoft"
               '("stroustrup"
                 (c-offsets-alist
                  (innamespace . -)
                  (inline-open . 0)
                  (inher-cont . c-lineup-multi-inher)
                  (arglist-cont-nonempty . +)
                  (template-args-cont . +))))
  (setq c-default-style "microsoft")

  (defun format-after-save()
    (when (eq major-mode 'c++-mode)
      (lsp-format-buffer)))
  (add-hook 'after-save-hook #'format-after-save))

(use-package cmake-mode
  :straight t
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'"         . cmake-mode))
  :bind (:map cmake-mode-map
         ;; Compatible with lsp-mode keybindings
         ("C-c d" . cmake-help))
  :config
  ;;(set-company-backends-for! cmake-mode company-cmake company-dabbrev-code company-dabbrev)
  )

(use-package tempo
  :ensure nil
  :after cc-mode
  :hook ((c-mode . c-mode-tempo-setup)
         (c++-mode . c++-mode-tempo-setup))
  :config
  (defvar c-tempo-tags nil)
  (defvar c++-tempo-tags nil)

  (defun c-mode-tempo-setup ()
    (tempo-use-tag-list 'c-tempo-tags))
  (defun c++-mode-tempo-setup ()
    (tempo-use-tag-list 'c-tempo-tags)
    (tempo-use-tag-list 'c++-tempo-tags))

  (tempo-define-template "c-ifndef"
                         '("#ifndef " (P "ifndef-clause: " clause) > n
                           "#define " (s clause) n> p n
                           "#endif // " (s clause) n>
                           )
                         "ifndef"
                         "Insert #ifndef #define #endif directives"
                         'c-tempo-tags)
  (tempo-define-template "c-main"
                         '("int main(int argc, char* argv[]) {" > n>
                           p n
                           "}" > n>
                           )
                         "main"
                         "Insert a main function"
                         'c-tempo-tags))

