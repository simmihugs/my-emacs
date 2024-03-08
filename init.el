;; Disable this annoying bell!!!!
(setq ring-bell-function 'ignore visible-bell nil)

;; Evaluate buffer for emacs-lisp
(define-key emacs-lisp-mode-map "\C-c\C-c" 'eval-buffer)
(define-key lisp-interaction-mode-map "\C-c\C-c" 'eval-buffer)

;; Make UI more usable
(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq inhibit-startup-screen t)


;; Remove unnessecary typing
(defalias 'yes-or-no-p 'y-or-n-p)
(setq read-file-name-completion-ignore-case t)

;; Highlight current line
(global-hl-line-mode +1)

;; Make editing more intuitiv
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(delete-selection-mode 1)


;; Structural editing
(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-+") 'hs-show-block)
(global-set-key (kbd "C--") 'hs-hide-block)

(defun my-hide-all()
  (interactive)
  (hs-minor-mode)
  (hs-hide-all))
(add-hook 'c-mode-hook 'my-hide-all)
(add-hook 'emacs-lisp-mode-hook 'my-hide-all)


;; Bridge german an english keyboard
(global-set-key (kbd "C-z") 'yank)
(global-set-key (kbd "C-?") 'undo)


;; Make isearch actually usable
(defadvice isearch-search (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)))


;; Kill current word!
(defun my-kill-thing-at-point (thing)
  "Kill the `thing-at-point' for the specified kind of THING."
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
      (kill-region (car bounds) (cdr bounds))
      (error "No %s at point" thing))))

(defun my-kill-word-at-point ()
  "Kill the word at point."
  (interactive)
  (my-kill-thing-at-point 'word))

(global-set-key (kbd "M-s") 'my-kill-word-at-point)

;; handle backup files better
(setq backup-directory-alist '(("*\\.gpg\\'")
			       ("." . "~/.config/emacs/backup")))


