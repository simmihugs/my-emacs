;;org
(use-package org
  :straight (:type built-in)
  :config 
  (require 'org-tempo)
  (setq org-startup-folded t)
  (setq fill-column 80 auto-fill-mode t)
  (setq org-adapt-indentation t)

   ;; org-babel
  (setq org-babel-python-command "python3")
  (advice-remove #'org-babel-do-load-languages #'ignore)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
     (haskell . t)
     (python . t)
     (clojure . t)))

  (setq org-confirm-babel-evaluate nil)

  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

  (defun addCheckBoxToTODO()
    (interactive)
    (progn
      (org-insert-todo-heading nil)
      (insert " [/]")
      (backward-char 4)))
  (define-key org-mode-map [M-S-return] 'addCheckBoxToTODO)

  (add-hook 'org-mode-hook 'turn-on-auto-fill)

   (setq org-directory "c:/Users/sgraetz/Documents/org")
  (setq org-agenda-files (list org-directory))
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  ;;(setq initial-buffer-choice (concat org-directory "/" "todo.org"))
  (setq initial-buffer-choice (concat org-directory "/" "week.org"))
  
  (defun my-init-hook ()
    (split-window-right)
    (let ((org-agenda-window-setup 'other-window))
      (org-agenda nil "a")))

  ;; "|" ist wichtig damit es funktioniert. alle davor sind todos, alle danach sind dones
  (setq org-todo-keywords
      '((sequence "TODO" "SUPPORT_ANFRAGEN" "SUPPORT_TICKET" "CLICKUP_ANLEGEN" "CLICKUP" "|" "DONE")))

  (add-hook 'window-setup-hook #'my-init-hook))



