;;org
(use-package org
  :straight (:type built-in)
  :config 
  (require 'org-tempo)
  (setq org-startup-folded t)
  (setq fill-column 80 auto-fill-mode t)
  (setq org-adapt-indentation t)

  ;; (setq org-cite-export-processors
  ;; 	'((latex biblatex)
  ;; 	  (t csl)))

  ;; (setq org-cite-global-bibliography
  ;; 	'("~/.config/emacs/bibliography/literature.bib"))

  ;; (setq org-image-actual-width '(300)
  ;; 	org-display-inline-images t
  ;; 	org-redisplay-inline-images t
  ;; 	org-startup-with-inline-images t
  ;; 	org-startup-with-inline-images "inlineimages")

  ;; (require 'ox-latex)
  ;; (require 'ox-html)  
  ;; (setq org-latex-listings t)
  ;; (add-to-list 'org-latex-packages-alist '("" "listings"))
  ;; (add-to-list 'org-latex-packages-alist '("" "color"))
  ;; (add-to-list 'org-latex-classes
  ;; 	       '("llncs"
  ;; 		 "\\documentclass{llncs}"
  ;; 		 ("\\section{%s}" . "\\section*{%s}")
  ;; 		 ("\\subsection{%s}" . "\\subsection*{%s}")
  ;; 		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  ;; (add-to-list 'org-latex-classes
  ;; 	       '("standalone"
  ;; 		 "\\documentclass{standalone}"
  ;; 		 ("\\section{%s}" . "\\section*{%s}")
  ;; 		 ("\\subsection{%s}" . "\\subsection*{%s}")
  ;; 		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  ;; (add-to-list 'org-latex-classes
  ;; 	       '("lmu-beamer"
  ;; 		 "\\documentclass[fleqn,compress,utf8,aspectratio=169,t,handout]{beamer}
  ;; 		  \\usetheme{LMU}
  ;; 		  \\input{recommended-settings}
  ;; 		  \\usepackage[style=ieee]{biblatex}
  ;; 		  \\usepackage[T1]{fontenc}
  ;; 		  \\usepackage{lmodern}
  ;; 		  \\usepackage{amsthm}
  ;; 		  \\usepackage{pict2e}
  ;; 		  \\usepackage{graphicx}
  ;; 		  \\usepackage[english]{babel}
  ;; 		  \\usepackage{fancyhdr}
  ;; 		  \\usepackage{color}
  ;; 		  \\usepackage{mathtools}
  ;; 		  \\usepackage{datetime}
  ;; 		  \\usepackage{ulem}
  ;; 		  \\usepackage{fancybox}
  ;; 		  \\usepackage{tikz}
  ;; 		  \\usetikzlibrary{shadows}
  ;; 		  \\usetikzlibrary {arrows.meta}
  ;; 		  \\usetikzlibrary{shapes.geometric}
  ;; 		  \\usepackage{subcaption}
  ;; 		  \\usepackage{microtype}
  ;; 		  \\usepackage{enumitem}
  ;; 		  \\usepackage{nicefrac}
  ;; 		  \\institute{LMU Munich}"
  ;; 		 ("\\section{%s}" . "\\section*{%s}")
  ;; 		 ("\\begin{frame}[c]\\frametitle{%s}"
  ;; 		  "\\end{frame}"
  ;; 		  "\\begin{frame}[c]\\frametitle{%s}"
  ;; 		  "\\end{frame}")))

  ;; ;;open pdf in evince
  ;; (add-hook 'org-mode-hook
  ;; 	    #'(lambda ()
  ;; 		(setq org-file-apps
  ;; 		      '((auto-mode . emacs)
  ;; 			("\\.mm\\'" . default)
  ;; 			("\\.x?html?\\'" . default)
  ;; 			("\\.pdf\\'" . "evince %s")))))

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

;;   (defun say-hello()
;;     (interactive)
;;     (message "hello"))

;;   :bind (:map org-mode-map
  ;; 	 ("<f5>" . say-hello))
  )

;; (add-hook 'org-mode-hook 'turn-on-auto-fill)
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (add-hook 'tex-mode-hook 'turn-on-auto-fill)
