(package-initialize)
(cond ((string= system-type "gnu/linux")
       (progn
         ;; linux
	 (load-file "~/.config/emacs/config/basics.el")
	 (load-file "~/.config/emacs/config/font-config.el")
	 (load-file "~/.config/emacs/config/straight-init.el")
         ;;
         ;; packages
         ;;
	 (load-file "~/.config/emacs/config/packages/orgmode.el")
	 (load-file "~/.config/emacs/config/packages/packages.el")
	 (load-file "~/.config/emacs/config/packages/lsp.el")
	 ;; (load-file "~/.config/emacs/config/packages/theme-config.el")
         (load-file "~/.config/emacs/config/packages/theme.el")	 
         ))
      (t
       (progn
         ;; windows
	 (load-file "~/.emacs.d/config/new-basics.el")
	 (load-file "~/.emacs.d/config/straight-init.el")
	 (load-file "~/.emacs.d/config/packages/orgmode.el")
	 (load-file "~/.emacs.d/config/packages/packages.el")
	 (load-file "~/.emacs.d/config/packages/lsp.el")
	 (load-file "~/.emacs.d/config/theme-config.el")
         )))

(custom-set-variables
 '(display-line-numbers 'absolute)
 '(org-agenda-files
   '("/home/simmi/Documents/org/thesis/Main.org"
     "/home/simmi/Documents/org/thesis/c:/Users/sgraetz/Documents/org/c:/Users/sgraetz/Documents/org/c:/Users/sgraetz/Documents/org")))
(custom-set-faces
 )

(global-display-line-numbers-mode -1)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame-set-input-focus frame)))

(setq initial-buffer-choice "~/Documents/org/thesis/Main.org")
