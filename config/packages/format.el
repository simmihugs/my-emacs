(use-package apheleia
  :straight t
  :config
  (apheleia-global-mode +1)

  (setq apheleia-mode-alist
        '((c-mode          . clang-format)
          (c++-mode        . clang-format)
          (python-mode     . black)
          ;; (rust-mode       . rustfmt)
          (emacs-lisp-mode . lisp-indent))))


(use-package prettier
  :straight t
  :hook ((js-mode         . prettier-mode)
         (typescript-mode . prettier-mode)
         (html-mode       . prettier-mode)
         (css-mode        . prettier-mode)
         (web-mode        . prettier-mode)
         (svelte-mode     . prettier-mode)))


;; (use-package rust-mode
;;   :straight t
;;   :hook (rust-mode . lsp-deferred)
;;   :config
;;   (require 'lsp-rust)
;;   (setq rust-format-on-save nil))
(use-package rust-mode
  :straight t
  :hook (rust-mode . lsp-deferred)
  :config
  (require 'lsp-rust)
  (setq rust-rustfmt-args '("--edition" "2021"))
  (add-hook 'rust-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'lsp-format-buffer nil t))))
