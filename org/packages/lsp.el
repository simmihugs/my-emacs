;; python
(use-package python-mode
  :straight t
  :config
  (setq python-basic-offset 4)
					;(define-key python-mode-map (kbd "C-l") 'comint-clear-buffer)
  :hook
  ((python-mode . flycheck-mode)
   (python-mode . lsp-deferred))
  :bind
  (:map python-mode-map
   ("C-l" . comint-clear-buffer)))

;; haskell
(use-package lsp-haskell
  :straight t)

;; (use-package haskell-mode
;;   :straight t
;;   :hook ((haskell-mode . flycheck-mode)
;; 	 (haskell-mode . lsp-deferred))
;;   :config
;;   (require 'lsp-haskell)
;;   (require 'haskell-interactive-mode)
;;   (require 'haskell-process)
;;   (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;   (custom-set-variables
;;    '(haskell-process-suggest-remove-import-lines t)
;;    '(haskell-process-auto-import-loaded-modules t)
;;    '(haskell-process-log t))
;;   :bind
;;   (:map haskell-interactive-mode-map
;;    ("C-c C-p" . haskell-interactive-switch)
;;    ("C-c C-l" . haskell-process-load-or-reload)
;;    ("C-`"     . haskell-interactive-bring)
;;    ("C-c C-t" . haskell-process-do-type)
;;    ("C-c C-i" . haskell-process-do-info)
;;    ("C-c C-c" . haskell-process-load-or-reload)
;;    ("C-l"     . haskell-interactive-mode-clear)
;;    ("C-c c"   . haskell-process-cabal)))

(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode)

;; rust
(use-package rust-mode
  :straight t
  :hook ((rust-mode . flycheck-mode)
	 (rust-mode . lsp-deferred))
  :bind (:map rust-mode-map
	 ("<f6>" . rfb)
	 ("<f5>" . rfr))
  :config
  (require 'rust-rustfmt)
  (defun rfb()
    (interactive)
    (rust-format-buffer)
    (save-buffer))
  (defun rfr()
    (interactive)
    (rfb)
    (lsp-rust-analyzer-rerun))
  (require 'lsp-rust)
  (autoload 'rust-mode "rust-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))
;; python
(use-package python-mode
  :straight t
  :config
  (setq python-basic-offset 4)
					;(define-key python-mode-map (kbd "C-l") 'comint-clear-buffer)
  :hook
  ((python-mode . flycheck-mode)
   (python-mode . lsp-deferred))
  :bind
  (:map python-mode-map
   ("C-l" . comint-clear-buffer)))

;; haskell
(use-package lsp-haskell
  :straight t)

;; (use-package haskell-mode
;;   :straight t
;;   :hook ((haskell-mode . flycheck-mode)
;; 	 (haskell-mode . lsp-deferred))
;;   :config
;;   (require 'lsp-haskell)
;;   (require 'haskell-interactive-mode)
;;   (require 'haskell-process)
;;   (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;   (custom-set-variables
;;    '(haskell-process-suggest-remove-import-lines t)
;;    '(haskell-process-auto-import-loaded-modules t)
;;    '(haskell-process-log t))
;;   :bind
;;   (:map haskell-interactive-mode-map
;;    ("C-c C-p" . haskell-interactive-switch)
;;    ("C-c C-l" . haskell-process-load-or-reload)
;;    ("C-`"     . haskell-interactive-bring)
;;    ("C-c C-t" . haskell-process-do-type)
;;    ("C-c C-i" . haskell-process-do-info)
;;    ("C-c C-c" . haskell-process-load-or-reload)
;;    ("C-l"     . haskell-interactive-mode-clear)
;;    ("C-c c"   . haskell-process-cabal)))

(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode)

;; rust
(use-package rust-mode
  :straight t
  :hook ((rust-mode . flycheck-mode)
	 (rust-mode . lsp-deferred))
  :bind (:map rust-mode-map
	 ("<f6>" . rfb)
	 ("<f5>" . rfr))
  :config
  (require 'rust-rustfmt)
  (defun rfb()
    (interactive)
    (rust-format-buffer)
    (save-buffer))
  (defun rfr()
    (interactive)
    (rfb)
    (lsp-rust-analyzer-rerun))
  (require 'lsp-rust)
  (autoload 'rust-mode "rust-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))
;; python
(use-package python-mode
  :straight t
  :config
  (setq python-basic-offset 4)
					;(define-key python-mode-map (kbd "C-l") 'comint-clear-buffer)
  :hook
  ((python-mode . flycheck-mode)
   (python-mode . lsp-deferred))
  :bind
  (:map python-mode-map
   ("C-l" . comint-clear-buffer)))

;; haskell
(use-package lsp-haskell
  :straight t)

;; (use-package haskell-mode
;;   :straight t
;;   :hook ((haskell-mode . flycheck-mode)
;; 	 (haskell-mode . lsp-deferred))
;;   :config
;;   (require 'lsp-haskell)
;;   (require 'haskell-interactive-mode)
;;   (require 'haskell-process)
;;   (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;   (custom-set-variables
;;    '(haskell-process-suggest-remove-import-lines t)
;;    '(haskell-process-auto-import-loaded-modules t)
;;    '(haskell-process-log t))
;;   :bind
;;   (:map haskell-interactive-mode-map
;;    ("C-c C-p" . haskell-interactive-switch)
;;    ("C-c C-l" . haskell-process-load-or-reload)
;;    ("C-`"     . haskell-interactive-bring)
;;    ("C-c C-t" . haskell-process-do-type)
;;    ("C-c C-i" . haskell-process-do-info)
;;    ("C-c C-c" . haskell-process-load-or-reload)
;;    ("C-l"     . haskell-interactive-mode-clear)
;;    ("C-c c"   . haskell-process-cabal)))

(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode)

;; rust
(use-package rust-mode
  :straight t
  :hook ((rust-mode . flycheck-mode)
	 (rust-mode . lsp-deferred))
  :bind (:map rust-mode-map
	 ("<f6>" . rfb)
	 ("<f5>" . rfr))
  :config
  (require 'rust-rustfmt)
  (defun rfb()
    (interactive)
    (rust-format-buffer)
    (save-buffer))
  (defun rfr()
    (interactive)
    (rfb)
    (lsp-rust-analyzer-rerun))
  (require 'lsp-rust)
  (autoload 'rust-mode "rust-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))

;; c/c++
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(add-hook 'c-mode-hook (lambda () (c-toggle-comment-style -1)))

(setq c-default-style "stroustrup"
      c-basic-offset 4)
(c-set-offset (quote cpp-macro) 0 nil)

(use-package html-mode
  :hook ((html-mode . lsp-deferred))
  ;; :config
  ;; (setq lsp-html-auto-closing-tags t)
  ;; (setq lsp-html-format-enable t)
  ;; (setq lsp-html-format-end-with-newline t)
  ;; (setq lsp-html-format-indent-inner-html t)
  ;; (setq lsp-html-suggest-html5 t)
  )

(use-package js-mode
  :hook ((js-mode . lsp-deferred))
  )


(use-package emmet-mode
  :straight t
  :hook ((sqml-mode .  emmet-mode)
	 (css-mode .  emmet-mode)
	 (emmet-mode . (lambda () (setq emmet-indentation 2)))
	 (emmet-mode . (lambda () (setq emmet-indent-after-insert nil))))
  :config (setq emmet-move-cursor-between-quotes t))
