(global-set-key (kbd "<mouse-3>") 'copy-region-as-kill)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key
 (kbd "C-+") 'hs-show-block)
(global-set-key (kbd "C--") 'hs-hide-block)

(setq backup-directory-alist
      '(("*\\.gpg\\'")
	("." . "~/.emacs.d/backup")))

(setq read-file-name-completion-ignore-case t)

(setq ring-bell-function 'ignore visible-bell nil)

(defun eshell/clear () 
  (interactive)
  (let ((eshell-buffer-maximum-lines 0)) (eshell-truncate-buffer)))

(defun my-eshell-clear ()
  "Clear `eshell' buffer, comint-style."
  (interactive)
  (let ((input (eshell-get-old-input)))
    (eshell/clear-scrollback)
    (eshell-emit-prompt)
    (insert input)))

(add-hook 'eshell-mode-hook
	  (lambda ()
	    (define-key eshell-mode-map (kbd "C-l") 'my-eshell-clear)))

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

(global-set-key (kbd "C-z") 'yank)
(global-set-key (kbd "C-?") 'undo)

(delete-selection-mode 1)

(defun aaa()
  (interactive)
  (eval-buffer) 
  (message "Buffer evaluated"))
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'aaa)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 100 1024 1024)) ;; 100 MB
(setq read-process-output-max (* 1 1024 1024)) ;; 1 MB

(if (eq system-type 'windows-nt)
    (setq emacs-dir "/mnt/c/Users/Simon/AppData/Roaming/.config/emacs")
  (setq emacs-dir "~/.emacs.d"))

(setq emacs-dir "~/emacs.d/")
(setq haskell-dir "~/Programms/haskell-projects/")
(setq programms-dir "~/Programms/")
(global-set-key
 (kbd "C-c p") (lambda() (interactive) (find-file programms-dir)))
(global-set-key
 (kbd "C-c e") (lambda() (interactive) (find-file emacs-dir)))
(global-set-key
 (kbd "C-c h") (lambda() (interactive) (find-file haskell-dir)))

(defun copy-buffer-name ()
  (interactive)
  (kill-new (buffer-file-name)))

(defun copy-current-directory ()
  (interactive)
  (kill-new (file-name-directory (buffer-file-name))))

(defun copy-current-directory-to-powershell ()
  (interactive)
  (let ((current-dir (file-name-directory (buffer-file-name))))
    (kill-new (concat "cd '" current-dir "'"))
    (message (concat "copied current dir: " current-dir))))

(global-set-key
 (kbd "C-c c") (lambda() (interactive) (copy-current-directory-to-powershell)))

(defun mydired-sort ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 1) ;; beyond dir. header 
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(add-hook 'dired-after-readin-hook 'mydired-sort)

(defadvice isearch-search (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)))
