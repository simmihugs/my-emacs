(use-package lsp-mode
  :straight t
  :init
  :hook ((python-mode . lsp-deferred)
	 (c-mode      . lsp-deferred)
	 (js-mode     . lsp-deferred)
	 (html-mode   . lsp-deferred)
	 (css-mode    . lsp-deferred)
	 (rust-mode   . lsp-deferred)
         (lsp-mode    . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :bind (("C-c C-f" . lsp-format-buffer)
         ("C-l" . lsp-find-definition))
  :config
  (setq lsp-clients-clangd-args
	'("--header-insertion=never")))

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



