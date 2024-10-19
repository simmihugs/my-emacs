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
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-winter-is-coming-dark-blue t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(cond
 ((find-font (font-spec :name "0xProto Nerd Font"))
  (set-face-attribute 'default nil :font "0xProto Nerd Font" :height 110))
 ((find-font (font-spec :name "Roboto Mono"))
  (set-face-attribute 'default nil :font "Roboto mono" :height 110))
 ((find-font (font-spec :name "IBM Plex mono"))
  (set-face-attribute 'default nil :font "IBM Plex mono" :height 120))
 ((find-font (font-spec :name "Chivo Mono"))
  (set-face-attribute 'default nil :font "Chivo Mono" :height 110))
 ((find-font (font-spec :name "SomeType Mono"))
  (set-face-attribute 'default nil :font "SomeType Mono" :height 120))
 ((find-font (font-spec :name "Iosevka NF"))
  (set-face-attribute 'default nil :font "Iosevka NF" :height 100))
 ((find-font (font-spec :name "cascadia code"))
  (set-face-attribute 'default nil :font "cascadia code" :height 120))
 ((find-font (font-spec :name "consolas"))
  (set-face-attribute 'default nil :font "consolas" :height 120))
 (t
  (message "no font found")))

