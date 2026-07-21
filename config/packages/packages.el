(use-package yasnippet
  :straight t
  :init
  (yas-global-mode 1)
  :config
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))


(use-package company
  :straight t
  :hook
  (after-init . global-company-mode))


(use-package which-key
  :straight t
  :config
  (which-key-mode))


(use-package flycheck
  :straight t)


(defun replace-from-top ()
  (interactive)
  (let ((orig-point (point)))
    (save-excursion
      (goto-char (point-min))
      (call-interactively 'vr/replace))
    (message "Back to old point.")
    (goto-char orig-point)))


(use-package visual-regexp
  :straight t
  :config
  (global-set-key (kbd "C-c r") 'vr/replace)
  (global-set-key (kbd "C-c q") 'vr/query-replace)
  (global-set-key (kbd "C-c m") 'vr/mc-mark)
  (global-set-key (kbd "C-c R") 'replace-from-top))


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


(use-package flycheck
  :straight t)



(use-package rainbow-delimiters
  :straight t
  :config
  (set-face-attribute 'rainbow-delimiters-depth-1-face    nil :foreground "#f0008b")
  (set-face-attribute 'rainbow-delimiters-depth-2-face    nil :foreground "#00fa9a")
  (set-face-attribute 'rainbow-delimiters-depth-3-face    nil :foreground "#ffa500")
  (set-face-attribute 'rainbow-delimiters-depth-4-face    nil :foreground "#f2200b")
  (set-face-attribute 'rainbow-delimiters-depth-5-face    nil :foreground "orange" )
  (set-face-attribute 'rainbow-delimiters-depth-6-face    nil :foreground "#f0008b")
  (set-face-attribute 'rainbow-delimiters-depth-7-face    nil :foreground "#00fa9a")
  (set-face-attribute 'rainbow-delimiters-depth-8-face    nil :foreground "#0000cd")
  (set-face-attribute 'rainbow-delimiters-depth-9-face    nil :foreground "#f2200b")
  (set-face-attribute 'rainbow-delimiters-mismatched-face nil :foreground "orange" )
  (set-face-attribute 'rainbow-delimiters-unmatched-face  nil :foreground "#f0008b")
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package paren
  :straight t
  :config
  (show-paren-mode t)
  (setq show-paren-style 'expression)
  (set-face-attribute 'show-paren-match nil
		              :foreground nil
		              :background nil
		              :slant 'italic))


(use-package magit
  :straight t
  :config
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))


(use-package git-gutter
  :straight t
  :diminish
  :hook ((prog-mode . git-gutter-mode))
  :init
  (setq git-gutter:update-interval 0.5))


(use-package nerd-icons
  :straight t)

(use-package nerd-icons-dired
  :straight t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package smartparens
  :straight t
  :config  (smartparens-global-mode t)
  (sp-local-pair 'emacs-lisp-mode "`" "'")
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'scheme-mode "`" "'")
  (sp-local-pair 'scheme-mode "'" nil :actions nil)
  (sp-local-pair 'geiser-repl-mode "`" "'")
  (sp-local-pair 'geiser-repl-mode "'" nil :actions nil)
  (sp-pair "'" nil :unless '(sp-point-after-word-p))
  (sp-local-pair 'css-mode "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair 'js-mode "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair 'c++-mode "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair 'rust-mode "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair 'c++-mode "{" nil :post-handlers '(("||\n[i]" "RET"))))


(use-package expand-region
  :straight t
  :bind
  (("C-0" . er/expand-region)))


(use-package emmet-mode
  :straight t
  :hook ((sqml-mode .  emmet-mode)
	     (css-mode .  emmet-mode)
	     (web-mode .  emmet-mode)         
	     (emmet-mode . (lambda () (setq emmet-indentation 2)))
	     (emmet-mode . (lambda () (setq emmet-indent-after-insert nil))))
  :config
  (setq emmet-move-cursor-between-quotes t))

(setq css-fontify-colors nil)

(defun my/draw-only-suffix-blocks ()
  "Zeichnet nur die Suffix-Blöcke und lässt den Text komplett in Ruhe."
  (save-excursion
    (goto-char (point-min))
    (remove-overlays (point-min) (point-max) 'my-custom-color-block t)
    (while (re-search-forward "#[a-fA-F0-9]\\{3,6\\}\\|[a-z]\\{3,20\\}" nil t)
      (let ((color (match-string 0)))
        (when (or (string-prefix-p "#" color) (color-defined-p color))
          (let* ((rgb (color-name-to-rgb color))
                 (lightness (+ (* (nth 0 rgb) 0.299)
                               (* (nth 1 rgb) 0.587)
                               (* (nth 2 rgb) 0.114)))                 
                 (border-color (if (> lightness 0.6) "#555555" "#FFFFFF")))
            (let ((ov (make-overlay (match-beginning 0) (match-end 0))))
              (overlay-put ov 'my-custom-color-block t)
              (overlay-put ov 'after-string 
                           (concat 
                            (propertize " " 'display '(space :width (2)))
                            (propertize " ▉" 'face `(:box ,border-color
                                                     :background ,color :foreground ,color)))))))))))
(add-hook 'css-mode-hook #'my/draw-only-suffix-blocks)
(add-hook 'web-mode-hook #'my/draw-only-suffix-blocks)

;;(add-hook 'after-save-hook #'my/draw-only-suffix-blocks)

(use-package json-mode
  :straight t)

(use-package yaml-mode
  :straight t
  :config (setq yaml-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

