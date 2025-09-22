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
  ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
  ;;(setq initial-buffer-choice (concat org-directory "/" "todo.org"))
  ;; (setq initial-buffer-choice (concat org-directory "/" "week.org"))
  
  ;; (defun my-init-hook ()
  ;;   (split-window-right)
  ;;   (let ((org-agenda-window-setup 'other-window))
  ;;     (org-agenda nil "a")))

  ;; "|" ist wichtig damit es funktioniert. alle davor sind todos, alle danach sind dones
  (setq org-todo-keywords
        '((sequence "TODO" "SUPPORT_ANFRAGEN" "SUPPORT_TICKET" "CLICKUP_ANLEGEN" "CLICKUP" "|" "DONE")))

  ;;  (add-hook 'window-setup-hook #'my-init-hook)

  ;; (setq org-preview-latex-process-alist
  ;;       '((lualatex :programs ("lualatex" "dvisvgm")
  ;;                   :description "dvi > svg"
  ;;                   :message "you need to install the programs: lualatex and dvisvgm."
  ;;                   :image-input-type "dvi"
  ;;                   :image-output-type "svg"
  ;;                   :image-size-adjust (1.0 . 1.0)
  ;;                   :latex-compiler
  ;;           ("lualatex --interaction=nonstopmode --shell-escape --output-format=dvi --output-directory=%o %f")
  ;;           :image-converter
  ;;           ("dvisvgm %f -n -b min -c %S -o %O"))))
  ;; (setq org-preview-latex-process 'lualatex)

  (add-to-list 'org-latex-packages-alist '("" "minted" nil))
  (setq org-latex-src-block-backend 'minted)

  ;;(require 'org-cite)
  (setq org-cite-export-processors '((latex biblatex)))
  (setq org-latex-pdf-process '("latexmk -gg -lualatex --shell-escape %f"))
  ;;(setq org-latex-pdf-process
  ;;      '("latexmk -lualatex='lualatex -interaction nonstopmode' -pdf -f %f"))
  ;; (setq org-latex-pdf-process '("latexmk -lualatex='lualatex --shell-escape -interaction nonstopmode' -pdf -f %f"))

  (with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
                 '("scrreprt" "\\documentclass[paper=A4,twoside=true,openright,
                                               parskip=full,chapterprefix=true,
                                               11pt,headings=normal,bibliography=totoc,
                                               listof=totoc,titlepage=on,captions=tableabove,
                                               chapterprefix=false,appendixprefix=false,
                                               draft=false]{scrreprt}"
                   ("\\chapter{%s}" . "\\chapter*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
  )


(use-package org-ref
  :straight t
  :config
  (setq bibtex-completion-bibliography '("./bib-refs.bib"))
  (define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)
  (setq org-ref-insert-cite-function
        (lambda ()
	  (org-cite-insert nil))))


(use-package ivy-bibtex
  :straight t
  :init
  (setq bibtex-completion-bibliography '("~/Dropbox/emacs/bibliography/references.bib"
					 "~/Dropbox/emacs/bibliography/dei.bib"
					 "~/Dropbox/emacs/bibliography/master.bib"
					 "~/Dropbox/emacs/bibliography/archive.bib")
	bibtex-completion-library-path '("~/Dropbox/emacs/bibliography/bibtex-pdfs/")
	bibtex-completion-notes-path "~/Dropbox/emacs/bibliography/notes/"
	bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

	bibtex-completion-additional-search-fields '(keywords)
	bibtex-completion-display-formats
	'((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
	  (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
	  (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
	  (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
	  (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
	bibtex-completion-pdf-open-function
	(lambda (fpath)
	  (call-process "open" nil 0 nil fpath))))

