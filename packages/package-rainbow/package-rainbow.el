(use-package rainbow-delimiters
  :hook
  (emacs-lisp-mode . rainbow-delimiters-mode)
  :config (custom-set-faces
	   '(rainbow-delimiters-depth-1-face
	     ((t (:inherit rainbow-delimiters-base-face :foreground "#DB0077"))))
	   '(rainbow-delimiters-depth-2-face
	     ((t (:inherit rainbow-delimiters-base-face :foreground "#0052CC"))))
	   '(rainbow-delimiters-depth-3-face
	     ((t (:inherit rainbow-delimiters-base-face :foreground "#EE7600"))))
	   '(rainbow-delimiters-depth-4-face
	     ((t (:inherit rainbow-delimiters-base-face :foreground "#00753B"))))
	   '(rainbow-delimiters-depth-5-face
	     ((t (:inherit rainbow-delimiters-base-face :foreground "#ff2200"))))
	   '(rainbow-delimiters-depth-6-face
	     ((t (:inherit rainbow-delimiters-base-face :foreground "#fbff00"))))))

(use-package rainbow-mode
  :defer t
  :config
  (add-hook 'rainbow-mode-hook
	    (hl-line-mode (if rainbow-mode -1 +1)))
  :hook
  (prog-mode))
