(use-package exec-path-from-shell
  :straight t
  :config (exec-path-from-shell-initialize))

(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook ((python-mode
          c-mode
          c++-mode
          js-mode
          typescript-mode 
          web-mode
          html-mode
          css-mode
          svelte-mode) . lsp-deferred)
  :config
  (setq lsp-enable-indentation nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-idle-delay 0.500)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-document-color-modes nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-prefer-capf t)
  (setq lsp-clients-clangd-args '("--header-insertion=never"))
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1))

(use-package typescript-mode
  :straight t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred))

(use-package svelte-mode
  :straight t
  :mode "\\.svelte\\'"
  :config
  (customize-set-variable 'svelte-basic-offset 2))

(defun my-force-ace-window-keys ()
  "Erzwingt M-o für ace-window in diesem Puffer."
  (local-set-key (kbd "M-o") 'ace-window))

(add-hook 'svelte-mode-hook 'my-force-ace-window-keys)
(add-hook 'html-mode-hook 'my-force-ace-window-keys)
(add-hook 'mhtml-mode-hook 'my-force-ace-window-keys)



(use-package apheleia
  :straight t
  :config
  (apheleia-global-mode +1)

  (setq apheleia-mode-alist
        '(          (c-mode          . clang-format)
                    (c++-mode        . clang-format)
                    (python-mode     . black)
                    (rust-mode       . rustfmt)
                    (emacs-lisp-mode . lisp-indent))))
(use-package prettier
  :straight t
  :hook ((js-mode         . prettier-mode)
         (typescript-mode . prettier-mode)
         (html-mode       . prettier-mode)
         (css-mode        . prettier-mode)
         (web-mode        . prettier-mode)
         (svelte-mode     . prettier-mode)))


(use-package rust-mode
  :straight t
  :hook (rust-mode . lsp-deferred)
  :config
  (require 'lsp-rust)
  (setq rust-format-on-save nil))



(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-capf))
