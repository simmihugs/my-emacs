
(set-language-environment "UTF-8")

(setq ring-bell-function 'ignore visible-bell nil)

(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq inhibit-startup-screen t)
;; Highlight current line
(global-hl-line-mode +1)
;; linenumbers
(custom-set-variables
 '(display-line-numbers 'absolute))

(cond
 ((find-font (font-spec :name "IBM Plex mono"))
  (set-face-attribute 'default nil :font "IBM Plex mono" :height 110))
 ((find-font (font-spec :name "Chivo Mono"))
  (set-face-attribute 'default nil :font "Chivo Mono" :height 110))
 ((find-font (font-spec :name "SomeType Mono"))
  (set-face-attribute 'default nil :font "SomeType Mono" :height 120))
 ((find-font (font-spec :name "Iosevka NF"))
  (set-face-attribute 'default nil :font "Iosevka NF" :height 100))
 ((find-font (font-spec :name "cascadia code"))
  (set-face-attribute 'default nil :font "cascadia code" :height 120))
 (t (set-face-attribute 'default nil :font "consolas" :height 120)))

(define-key emacs-lisp-mode-map "\C-c\C-c" 'eval-buffer)
(define-key lisp-interaction-mode-map "\C-c\C-c" 'eval-buffer)

(defalias 'yes-or-no-p 'y-or-n-p)
(setq read-file-name-completion-ignore-case t)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(delete-selection-mode 1)

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-+") 'hs-show-block)
(global-set-key (kbd "C--") 'hs-hide-block)

(defun my-hide-all()
  (interactive)
  (hs-minor-mode)
  (hs-hide-all))
(add-hook 'c-mode-hook 'my-hide-all)
(add-hook 'emacs-lisp-mode-hook 'my-hide-all)

(global-set-key (kbd "C-z") 'yank)
(global-set-key (kbd "C-?") 'undo)

(defadvice isearch-search (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)))

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

(setq backup-directory-alist '(("*\\.gpg\\'")
			       ("." . "~/.config/emacs/backup")))

(setq scroll-preserve-screen-position 1)
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))
(setq scroll-step            1
      scroll-conservatively  10000)

(put 'if 'lisp-indent-function 'defun)
(put 'format 'lisp-indent-function 'defun)
(put 'cl-loop 'lisp-indent-function 'defun)

;; before
;;   (:foo bar
;;         :baz qux)
;; after
;;   (:foo bar
;;    :baz qux)
(eval-after-load "lisp-mode"
  '(defun lisp-indent-function (indent-point state)
     (let ((normal-indent (current-column))
	   (orig-point (point)))
       (goto-char (1+ (elt state 1)))
       (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
       (cond
	;; car of form doesn't seem to be a symbol, or is a keyword
	((and (elt state 2)
	      (or (not (looking-at "\\sw\\|\\s_"))
		  (looking-at ":")))
	 (if (not (> (save-excursion (forward-line 1) (point))
		     calculate-lisp-indent-last-sexp))
	   (progn (goto-char calculate-lisp-indent-last-sexp)
		  (beginning-of-line)
		  (parse-partial-sexp (point)
				      calculate-lisp-indent-last-sexp 0 t)))
	 ;; Indent under the list or under the first sexp on the same
	 ;; line as calculate-lisp-indent-last-sexp.  Note that first
	 ;; thing on that line has to be complete sexp since we are
	 ;; inside the innermost containing sexp.
	 (backward-prefix-chars)
	 (current-column))
	((and (save-excursion
		(goto-char indent-point)
		(skip-syntax-forward " ")
		(not (looking-at ":")))
	      (save-excursion
		(goto-char orig-point)
		(looking-at ":")))
	 (save-excursion
	   (goto-char (+ 2 (elt state 1)))
	   (current-column)))
	(t
	 (let ((function (buffer-substring (point)
					   (progn (forward-sexp 1) (point))))
	       method)
	   (setq method (or (function-get (intern-soft function)
					  'lisp-indent-function)
			    (get (intern-soft function) 'lisp-indent-hook)))
	   (cond ((or (eq method 'defun)
		      (and (null method)
			   (> (length function) 3)
			   (string-match "\\`def" function)))
		  (lisp-indent-defform state indent-point))
		 ((integerp method)
		  (lisp-indent-specform method state
					indent-point normal-indent))
		 (method
		  (funcall method indent-point state)))))))))

(defun copy-current-file-path (&optional DirPathOnlyQ)
  (interactive "P")
  (let (($fpath
	 (if (string-equal major-mode 'dired-mode)
	   (progn
	     (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
	       (if (equal (length $result) 0)
		 (progn default-directory )
		 (progn $result))))
	   (if (buffer-file-name)
	     (buffer-file-name)
	     (expand-file-name default-directory)))))
    (kill-new
     (if DirPathOnlyQ
       (progn
	 (message "Directory copied: %s" (file-name-directory $fpath))
	 (file-name-directory $fpath))
       (progn
	 (message "File path copied: %s" $fpath)
	 $fpath )))))

(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "\C-c\C-c" 'copy-current-file-path)))

