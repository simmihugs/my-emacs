(use-package vterm
  :straight t
  :config
  (setq vterm-max-scrollback 10000)
  ;; ;; evtl noetiger mac fix
  ;; (setq mac-option-modifier 'meta)

  (with-eval-after-load 'vterm
    (define-key comint-mode-map (kbd "C-l") #'comint-clear-buffer)))

(with-eval-after-load 'comint
  (define-key comint-mode-map (kbd "C-l") #'comint-clear-buffer))


(with-eval-after-load 'term
  (define-key comint-mode-map (kbd "C-l") #'comint-clear-buffer))

(use-package eshell-toggle
  :straight t
  :bind ("C-M-'" . eshell-toggle)
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-run-command nil))


(defun eshell/clear () 
  (interactive)
  (let ((eshell-buffer-maximum-lines 0)) (eshell-truncate-buffer)))


(defun my/eshell-clear ()
  "Clear `eshell' buffer, comint-style."
  (interactive)
  (let ((input (eshell-get-old-input)))
    (eshell/clear-scrollback)
    (eshell-emit-prompt)
    (insert input)))

(add-hook
 'eshell-mode-hook
 (lambda ()
   (define-key eshell-mode-map (kbd "C-l") 'my/eshell-clear)))

