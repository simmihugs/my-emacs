(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq auto-revert-check-vc-info t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-github t)
  (setq doom-modeline-github-interval (* 30 60)))


(use-package doom-themes
  :straight t
  :config
  (setq doom-themes-enable-bold t    
        doom-themes-enable-italic t) 
  (load-theme 'doom-tomorrow-day t)

  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-tomorrow-day")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))


(set-face-attribute 'hl-line nil
                    :foreground nil
                    :underline nil
                    :box '(:line-width (-1 . -1) :color "#a7da1e"))

(set-face-attribute 'org-document-title nil :foreground "blue")
(dolist (org-element '(org-document-info-keyword
                       org-done
                       org-drawer
                       org-ellipsis
                       org-headline-done))
  (set-face-attribute org-element nil :foreground "green"))


