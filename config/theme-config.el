(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq auto-revert-check-vc-info t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-github t)
  (setq doom-modeline-github-interval (* 30 60)))


;; (use-package autothemer
;;   :straight t)
;; (use-package github-dark-theme
;;   :straight (github-dark-theme :type git
;;                                :host github
;;                                :repo "ladroid/github-emacs-theme")
;;   :config
;;   (load-theme 'github-dark t))

(use-package doom-themes
  :straight t
  :config
  (setq doom-themes-enable-bold t    
        doom-themes-enable-italic t) 
  (load-theme 'doom-bluloco-light t)

  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-bluloco-light")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; (use-package kanagawa-theme
;;   :straight (:host github :repo "zikajk/emacs-kanagawa-theme")
;;   :init (load-theme 'kanagawa t))


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



