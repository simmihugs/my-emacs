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
         (load-file "~/.config/emacs/config/packages/theme.el")	 
         ))
      ((string= system-type "darwin")
       (progn
         ;; mac
	     (load-file "~/.config/emacs/config/basics.el")
	     (load-file "~/.config/emacs/config/font-config.el")
	     (load-file "~/.config/emacs/config/straight-init.el")
         ;;
         ;; packages
         ;;
	     (load-file "~/.config/emacs/config/packages/orgmode.el")
	     (load-file "~/.config/emacs/config/packages/packages.el")
         (load-file "~/.config/emacs/config/packages/language-server.el")
         (load-file "~/.config/emacs/config/packages/format.el")
         (load-file "~/.config/emacs/config/packages/theme.el")
         (load-file "~/.config/emacs/config/packages/ace-windows.el")
         (load-file "~/.config/emacs/config/packages/terminal.el")
         (load-file "~/.config/emacs/config/packages/dape.el")
         (load-file "~/.config/emacs/config/packages/dape.el")
         (load-file "~/.config/emacs/config/packages/lisp-setup.el")
         ;;
         ;; own packages
         ;;
         (load-file "~/.config/emacs/config/my-packages/live-server.el")
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
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers 'absolute)
 '(org-agenda-files
   '("/home/simmi/Documents/org/thesis/Main.org"
     "/home/simmi/Documents/org/thesis/c:/Users/sgraetz/Documents/org/c:/Users/sgraetz/Documents/org/c:/Users/sgraetz/Documents/org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-display-line-numbers-mode -1)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame-set-input-focus frame)))

(put 'erase-buffer 'disabled nil)
