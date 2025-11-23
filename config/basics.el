(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(set-language-environment "UTF-8")

(setq ring-bell-function 'ignore visible-bell nil)

(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)

(defun my/recenter-top-only ()
  "Recenter the current line to the top of the window, bypassing the centering step."
  (interactive)
  (recenter-top-bottom -1))

(setq inhibit-startup-screen t)
;; Highlight current line
(global-hl-line-mode +1)
;; linenumbers
;;(custom-set-variables
;; '(display-line-numbers 'absolute))

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

(global-set-key (kbd "C-z") 'yank)
(global-set-key (kbd "C-?") 'undo)

(defun my/kill-thing-at-point (thing)
  "Kill the `thing-at-point' for the specified kind of THING."
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
      (kill-region (car bounds) (cdr bounds))
      (error "No %s at point" thing))))

(defun my/kill-word-at-point ()
  "Kill the word at point."
  (interactive)
  (my/kill-thing-at-point 'word))

(global-set-key (kbd "M-s") 'my/kill-word-at-point)

(setq backup-directory-alist '(("*\\.gpg\\'")
			       ("." . "~/.config/emacs/backup")))

(setq scroll-preserve-screen-position nil) 
(setq scroll-conservatively 10000) 
(setq scroll-margin 3)


(global-set-key (kbd "M-p") 'scroll-down-line)
(global-set-key (kbd "M-n") 'scroll-up-line)

(put 'if 'lisp-indent-function 'defun)
(put 'format 'lisp-indent-function 'defun)
(put 'cl-loop 'lisp-indent-function 'defun)

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



(defun my/upcase-region-or-char ()
  "Uppercase the character at point without moving the cursor."
  (interactive)
  (let ((pos (point)))
    (when (characterp (char-after))
      (let ((char (char-after)))
        (unless (eq char (upcase char))
          (save-excursion
            (goto-char pos)
            (delete-char 1)
            (insert-char (upcase char))))))))

(defun my/downcase-region-or-char ()
  "Lowercase the character at point without moving the cursor."
  (interactive)
  (let ((pos (point)))
    (when (characterp (char-after))
      (let ((char (char-after)))
        (unless (eq char (downcase char))
          (save-excursion
            (goto-char pos)
            (delete-char 1)
            (insert-char (downcase char))))))))

(global-set-key (kbd "C-x C-u") 'my/upcase-region-or-char)
(global-set-key (kbd "C-x C-l") 'my/downcase-region-or-char)

(defvar my/select-cycle-state 0
  "State for cycling through word, line, paragraph selection.")

(defvar my/select-cycle-orig-point nil
  "Original point before cycling selection started.")

(defun my/select-current-word ()
  "Select the word at point."
  (let ((bounds (bounds-of-thing-at-point 'word)))
    (when bounds
      (goto-char (car bounds))
      (set-mark (cdr bounds)))))

(defun my/select-current-line ()
  "Select the current line."
  (beginning-of-line)
  (set-mark (line-end-position)))

(defun my/select-current-paragraph ()
  "Select the current paragraph."
  (let ((start (save-excursion (backward-paragraph) (point)))
        (end (save-excursion (forward-paragraph) (point))))
    (goto-char start)
    (set-mark end)))

(defun my/cycle-select-region ()
  "Cycle selection: word -> line -> paragraph -> none."
  (interactive)
  (cond
   ((equal my/select-cycle-state 0)
    (setq my/select-cycle-orig-point (point))
    (my/select-current-word)
    (setq my/select-cycle-state 1))
   ((equal my/select-cycle-state 1)
    (my/select-current-line)
    (setq my/select-cycle-state 2))
   ((equal my/select-cycle-state 2)
    (my/select-current-paragraph)
    (setq my/select-cycle-state 3))
   ((equal my/select-cycle-state 3)
    (deactivate-mark)
    (goto-char my/select-cycle-orig-point)
    (setq my/select-cycle-state 0))))


(global-set-key (kbd "C-c s") 'my/cycle-select-region)
