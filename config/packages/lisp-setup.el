(let ((ros-helper (expand-file-name "~/.roswell/helper.el")))
  (when (file-exists-p ros-helper)
    (load ros-helper)))

(use-package slime
  :straight t
  :init
  (setq inferior-lisp-program "ros -Q run")
  :config
  (slime-setup '(slime-fancy slime-quicklisp slime-asdf))
  (setq slime-net-coding-system 'utf-8-unix))

(use-package slime-company
  :straight t
  :after (slime company)
  :config
  (slime-setup '(slime-fancy slime-company)))
