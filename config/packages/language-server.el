(use-package exec-path-from-shell
  :straight t
  :config (exec-path-from-shell-initialize))

(use-package lsp-mode
  :straight t
  :init
  (setq lsp-keymap-prefix "C-c l")
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
  (setq company-minimum-prefix-length 1)

  ;; (with-eval-after-load 'lsp-mode
  ;;   (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

  (with-eval-after-load 'lsp-mode
    ;; Refactoring & Actions
    (define-key lsp-mode-map (kbd "C-c l r") 'lsp-rename)
    (define-key lsp-mode-map (kbd "C-c l a") 'lsp-execute-code-action)
    (define-key lsp-mode-map (kbd "C-c l o") 'lsp-organize-imports)
    (define-key lsp-mode-map (kbd "C-c l f") 'lsp-format-buffer)

    ;; Navigation & Info
    (define-key lsp-mode-map (kbd "C-c l g") 'lsp-find-definition)
    (define-key lsp-mode-map (kbd "C-c l d") 'lsp-find-references)
    (define-key lsp-mode-map (kbd "C-c l h") 'lsp-describe-thing-at-point)

    ;; Workspace / Diagnostics
    (define-key lsp-mode-map (kbd "C-c l s") 'lsp-workspace-restart)
    (define-key lsp-mode-map (kbd "C-c l e") 'flycheck-list-errors))
  )

;; Enable lsp-mode's built-in visual menu
(use-package lsp-ui
  :straight t
  :config
  (define-key lsp-mode-map (kbd "C-c l ?") 'lsp-ui-doc-glance))

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

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-capf))
