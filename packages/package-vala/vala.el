(setq lsp-clients-vala-ls-executable "/usr/bin/vala-language-server")

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection "vala-language-server")
		  :activation-fn (lsp-activate-on "vala")
		  :server-id 'valals))

(use-package vala-mode
    :hook ((vala-mode) . (lambda () (lsp)))
    :config
    (with-eval-after-load "lsp-mode"
      (add-to-list 'lsp-enabled-clients 'valals))
    (add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
    (add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
    (add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
    (add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))
    (sp-local-pair 'vala-mode "{" nil :post-handlers '(("||\n[i]" "RET"))))
