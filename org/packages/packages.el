;; ace-window
(use-package ace-window
  :straight t
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  ("M-o" . ace-window))


;; yasnippet
(use-package yasnippet
  :straight t
  :init
  (yas-global-mode 1)
  :config
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))


;; company
(use-package company
  :straight t
  :hook
  (after-init . global-company-mode))


;; which-key
(use-package which-key
  :straight t
  :config
  (which-key-mode))


(use-package flycheck
  :straight t)


;; visual regexp
(defun replace-from-top ()
  (interactive)
  (let ((orig-point (point)))
    (save-excursion
      (goto-char (point-min))
      (call-interactively 'vr/replace))
    (message "Back to old point.")
    (goto-char orig-point)))


;; visual-regexp
(use-package visual-regexp
  :straight t
  :config
  (global-set-key (kbd "C-c r") 'vr/replace)
  (global-set-key (kbd "C-c q") 'vr/query-replace)
  (global-set-key (kbd "C-c m") 'vr/mc-mark)
  (global-set-key (kbd "C-c R") 'replace-from-top))


;; dired
(use-package dired-sidebar
  :straight t
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
	    (lambda ()
	      (unless (file-remote-p default-directory)
		(auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)  
  (setq dired-sidebar-subtree-line-prefix " \u25BE ")
  (setq dired-sidebar-theme 'all-the-icons)
  (setq dired-sidebar-use-term-integration t))

;; flycheck
(use-package flycheck
  :straight t)

;; eshell
(use-package eshell-toggle
  :straight t
  :bind ("C-M-'" . eshell-toggle)
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-run-command nil))

(defun eshell/clear () 
  (interactive)
  (let ((eshell-buffer-maximum-lines 0)) (eshell-truncate-buffer)))

(defun my-eshell-clear ()
  "Clear `eshell' buffer, comint-style."
  (interactive)
  (let ((input (eshell-get-old-input)))
    (eshell/clear-scrollback)
    (eshell-emit-prompt)
    (insert input)))

(add-hook
 'eshell-mode-hook
 (lambda ()
   (define-key eshell-mode-map (kbd "C-l") 'my-eshell-clear)))

;; rainbow delimiters
(use-package rainbow-delimiters
  :straight t
  :config
  (set-face-attribute 'rainbow-delimiters-depth-1-face    nil :foreground "#f0008b")
  (set-face-attribute 'rainbow-delimiters-depth-2-face    nil :foreground "#00fa9a")
  (set-face-attribute 'rainbow-delimiters-depth-3-face    nil :foreground "#0000cd")
  (set-face-attribute 'rainbow-delimiters-depth-4-face    nil :foreground "#f2200b")
  (set-face-attribute 'rainbow-delimiters-depth-5-face    nil :foreground "orange" )
  (set-face-attribute 'rainbow-delimiters-depth-6-face    nil :foreground "#f0008b")
  (set-face-attribute 'rainbow-delimiters-depth-7-face    nil :foreground "#00fa9a")
  (set-face-attribute 'rainbow-delimiters-depth-8-face    nil :foreground "#0000cd")
  (set-face-attribute 'rainbow-delimiters-depth-9-face    nil :foreground "#f2200b")
  (set-face-attribute 'rainbow-delimiters-mismatched-face nil :foreground "orange" )
  (set-face-attribute 'rainbow-delimiters-unmatched-face  nil :foreground "#f0008b")
  :hook (prog-mode . rainbow-delimiters-mode))


;; rainbow mode
(use-package rainbow-mode
  :straight t
  :ensure t
  :hook prog-mode)


;; paren
(use-package paren
  :straight t
  :config
  (show-paren-mode t)
  (setq show-paren-style 'expression)
  (set-face-attribute 'show-paren-match nil
		      :foreground nil
		      :background nil
		      :slant 'italic))

;; magit
(use-package magit
  :straight t
  :config
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

;; nerd-icons
(use-package nerd-icons
  :straight t)


;; nerd-icons-dired
(use-package nerd-icons-dired
  :straight t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; smartparens
(use-package smartparens
  :straight t
  :config
  (smartparens-global-mode t)

  ;; pair "`" with "'" in emacs-lisp-mode
  (sp-local-pair 'emacs-lisp-mode "`" "'")
  ;; no '' pair in emacs-lisp-mode
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

  ;; pair "`" with "'" in emacs-lisp-mode
  (sp-local-pair 'scheme-mode "`" "'")
  ;; no '' pair in emacs-lisp-mode
  (sp-local-pair 'scheme-mode "'" nil :actions nil)

  ;; pair "`" with "'" in emacs-lisp-mode
  (sp-local-pair 'geiser-repl-mode "`" "'")
  ;; no '' pair in emacs-lisp-mode
  (sp-local-pair 'geiser-repl-mode "'" nil :actions nil)

  ;; don't pair "'" if we're at the end of a word (like when typing an
  ;; apostrophe)
  (sp-pair "'" nil :unless '(sp-point-after-word-p))
  (sp-local-pair 'c++-mode "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair 'rust-mode "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair 'c++-mode "{" nil :post-handlers '(("||\n[i]" "RET"))))


