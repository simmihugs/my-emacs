;; (use-package github-dark-vscode-theme
;;   :straight (github-dark-vscode :type git
;; 				:host github
;; 				:repo "simmihugs/github-dark-theme")
;;   :config (load-theme 'github-dark-vscode t))

(use-package adwaita-dark-theme
  :straight t
  :config (load-theme 'adwaita-dark t))

;; (use-package github-theme
;;   :straight t
;;   :config (load-theme 'github t))

(defun set-highlight(color)
  (progn
    (set-face-attribute 'highlight nil :foreground nil :background nil)
    (set-face-attribute 'hl-line nil :box `(:line-width (-1 . -1)
					    :color ,color
					    :style release-button))))
(defun set-region(color)
  (set-face-attribute 'region nil
 		      :background color))

(defun set-current-line-number(color)
  (set-face-attribute 'line-number-current-line nil
 		      :italic t
 		      :foreground color
 		      :background nil))

(defun set-cursor(color)
  (setq-default cursor-type '(box . 6))
  (set-face-attribute 'cursor nil
 		      :background color))

(defun set-mode-line(color1 color2 color3 color4)
  (set-face-attribute 'mode-line nil
 		      :foreground color1
 		      :background color2)
  (set-face-attribute 'mode-line-inactive nil
		      :foreground color3
		      :background color4))

(set-highlight "#a71d5d")
(set-region    "#363636")

(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq auto-revert-check-vc-info t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-github t)
  (setq doom-modeline-github-interval (* 30 60)))
