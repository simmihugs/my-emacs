(package-initialize)
(cond ((string= system-type "gnu/linux")
       (progn
         ;; linux
	 (load-file "~/.config/emacs/config/new-basics.el")
	 (load-file "~/.config/emacs/config/straight-init.el")
	 (load-file "~/.config/emacs/config/packages/orgmode.el")
	 (load-file "~/.config/emacs/config/packages/packages.el")
	 (load-file "~/.config/emacs/config/packages/lsp.el")
	 (load-file "~/.config/emacs/config/new-theme.el")
         ))
      (t
       (progn
         ;; windows
	 (load-file "~/.emacs.d/config/new-basics.el")
	 (load-file "~/.emacs.d/config/straight-init.el")
	 (load-file "~/.emacs.d/config/packages/orgmode.el")
	 (load-file "~/.emacs.d/config/packages/packages.el")
	 (load-file "~/.emacs.d/config/packages/lsp.el")
	 (load-file "~/.emacs.d/config/new-theme.el")
         )))

