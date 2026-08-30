(use-package vterm
  :straight t
  :config
  (setq vterm-max-scrollback 10000)
  ;; ;; evtl noetiger mac fix
  ;; (setq mac-option-modifier 'meta)

  (with-eval-after-load 'vterm
    (define-key comint-mode-map (kbd "C-l") #'comint-clear-buffer))
  (custom-set-faces
   '(vterm-color-blue ((t (:foreground "#61afef" :background "#61afef"))))
   '(vterm-color-bright-blue ((t (:foreground "#35bfef" :background "#35bfef")))))
  )

(use-package vterm-toggle
  :straight t
  :bind ("C-M-'" . vterm-toggle)
  :custom
  ;; Match your eshell-toggle height preference (e.g., 1/3 of the frame height)
  (vterm-toggle-hide-method 'delete-window)
  (vterm-toggle-scope 'project) ; or 'frame / 'default
  :config
  ;; Adjust popup height to roughly 33% (1/3 of frame, similar to size-fraction 3)
  (add-to-list 'display-buffer-alist
               '("^\\*vterm"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (dedicated . t)
                 (window-height . 0.33))))

(with-eval-after-load 'comint
  (define-key comint-mode-map (kbd "C-l") #'comint-clear-buffer))


(with-eval-after-load 'term
  (define-key comint-mode-map (kbd "C-l") #'comint-clear-buffer))

;; (use-package eshell-toggle
;;   :straight t
;;   :bind ("C-M-'" . eshell-toggle)
;;   :custom
;;   (eshell-toggle-size-fraction 3)
;;   (eshell-toggle-run-command nil))


;; (defun eshell/clear () 
;;   (interactive)
;;   (let ((eshell-buffer-maximum-lines 0)) (eshell-truncate-buffer)))


;; (defun my/eshell-clear ()
;;   "Clear `eshell' buffer, comint-style."
;;   (interactive)
;;   (let ((input (eshell-get-old-input)))
;;     (eshell/clear-scrollback)
;;     (eshell-emit-prompt)
;;     (insert input)))

;; (add-hook
;;  'eshell-mode-hook
;;  (lambda ()
;;    (define-key eshell-mode-map (kbd "C-l") 'my/eshell-clear)))

