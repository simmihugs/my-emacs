(use-package adwaita-dark-theme
  :straight (adwaita-dark :type git
			  :host gitlab
			  :repo "jessieh/adwaita-dark-theme")
  :config (load-theme 'adwaita-dark t))

(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq auto-revert-check-vc-info t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-github t)
  (setq doom-modeline-github-interval (* 30 60)))


(defun my/set-highlight (color)
  "Set hl-line highlight color safely across Emacs versions."
  (progn
    (set-face-attribute 'highlight nil :foreground nil :background nil)
    (if (version< emacs-version "30.0")
      (set-face-attribute 'hl-line nil :box `(:line-width (-1 . -1)
					      :color ,color
					      :style release-button))
      (set-face-attribute 'hl-line nil
                          :box `(:line-width -1
                                 :color ,color
                                 :style nil)))))

(defun my/set-region (color)
  "Set the `region` face background to COLOR."
  (set-face-attribute 'region nil
 		      :background color))

(defun my/set-current-line-number (color)
  "Set the `line-number-current-line` face foreground to COLOR and italicize it."

  (set-face-attribute 'line-number-current-line nil
 		      :italic t
 		      :foreground color
 		      :background nil))

(defun my/set-cursor(color)
  "Set the cursor face background to COLOR and use a box cursor of width 6."
  (setq-default cursor-type '(box . 6))
  (set-face-attribute 'cursor nil
 		      :background color))

(defun my/set-mode-line(color1 color2 color3 color4)
  "Set foreground and background colors for mode-line and inactive mode-line faces.
COLOR1 and COLOR2 are foreground and background for active mode-line.
COLOR3 and COLOR4 are foreground and background for inactive mode-line."
  (set-face-attribute 'mode-line nil
 		      :foreground color1
 		      :background color2)
  (set-face-attribute 'mode-line-inactive nil
		      :foreground color3
		      :background color4))

(my/set-highlight "#a71d5d")
(my/set-region    "#363636")

