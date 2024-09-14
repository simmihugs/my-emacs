(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq auto-revert-check-vc-info t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-github t)
  (setq doom-modeline-github-interval (* 30 60)))

(cond
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
 (t (set-face-attribute 'default nil :font "consolas" :height 120)))

