(use-package org
  :straight (:type built-in)
  :config 
  (require 'org-tempo)
  (setq org-startup-folded t)
  (setq fill-column 80 auto-fill-mode t)
  (setq org-adapt-indentation t)

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
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE")))

  (add-to-list 'org-latex-packages-alist '("" "minted" nil))
  (setq org-latex-src-block-backend 'minted)

  (setq org-cite-export-processors '((latex biblatex)))
  (setq org-latex-pdf-process '("latexmk -gg -lualatex --shell-escape %f"))

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

  (defun org-export-latex-pdf-and-save ()
    (interactive)
    (save-buffer)
    (org-latex-export-to-pdf))

  (setq org-cite-global-bibliography
        '("~/Documents/org/thesis/bib-refs.bib"))


  :hook
  (org-mode . (lambda ()
                (local-set-key (kbd "<f5>") 'org-export-latex-pdf-and-save))))




;; (use-package ivy-bibtex
;;   :straight t
;;   :init
;;   (setq bibtex-completion-bibliography '("~/Dropbox/emacs/bibliography/references.bib"
;; 					 "~/Dropbox/emacs/bibliography/dei.bib"
;; 					 "~/Dropbox/emacs/bibliography/master.bib"
;; 					 "~/Dropbox/emacs/bibliography/archive.bib")
;; 	bibtex-completion-library-path '("~/Dropbox/emacs/bibliography/bibtex-pdfs/")
;; 	bibtex-completion-notes-path "~/Dropbox/emacs/bibliography/notes/"
;; 	bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

;; 	bibtex-completion-additional-search-fields '(keywords)
;; 	bibtex-completion-display-formats
;; 	'((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
;; 	  (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
;; 	  (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
;; 	  (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
;; 	  (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
;; 	bibtex-completion-pdf-open-function
;; 	(lambda (fpath)
;; 	  (call-process "open" nil 0 nil fpath))))


;; (use-package org-ref
;;   :straight t
;;   :config
;;   (require 'org-ref-ivy)
;;   ;; (require 'org-ref-ivy)
;;   ;; (setq bibtex-completion-bibliography '("./bib-refs.bib"))
;;   (setq bibtex-completion-bibliography
;;         '("~/Documents/org/thesis/bib-refs.bib")
;;         ;; bibtex-completion-library-path '("~/path/to/pdfs/")
;;         ;; bibtex-completion-notes-path "~/path/to/notes/"
;;         bibtex-completion-additional-search-fields '(keywords)
;;         bibtex-completion-display-formats
;;         '((article . "${year:4} ${author:36} ${title:*} ${journal:40}")
;;           (t      . "${year:4} ${author:36} ${title:*}")))
;;   (define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)
;;   (setq org-ref-insert-cite-function
;;         (lambda ()
;; 	  (org-cite-insert nil))))


;; (require 'org-ref)
;; (require 'org-ref-ivy)

;; (setq bibtex-completion-bibliography
;;       '("~/Documents/org/thesis/bib-refs.bib")
;;       ;; bibtex-completion-library-path '("~/path/to/pdfs/")
;;       ;; bibtex-completion-notes-path "~/path/to/notes/"
;;       bibtex-completion-additional-search-fields '(keywords)
;;       bibtex-completion-display-formats
;;       '((article . "${year:4} ${author:36} ${title:*} ${journal:40}")
;;         (t      . "${year:4} ${author:36} ${title:*}")))


;; Install and configure ivy-bibtex with straight
(use-package ivy-bibtex
  :straight t
  :defer t
  :custom
  (bibtex-completion-bibliography
   '("~/Documents/org/thesis/bib-refs.bib"))
  ;; (bibtex-completion-library-path
  ;;  '("~/Dropbox/emacs/bibliography/bibtex-pdfs/"))
  ;; (bibtex-completion-notes-path
  ;;  "~/Dropbox/emacs/bibliography/notes/")
  (bibtex-completion-notes-template-multiple-files
   "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n")
  (bibtex-completion-additional-search-fields '(keywords))
  (bibtex-completion-display-formats
   '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
     (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
     (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
     (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
     (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}")))
  (bibtex-completion-pdf-open-function
   (lambda (fpath)
     (call-process "open" nil 0 nil fpath))))

;; Install and configure org-ref, set up org-mode keybinding
(use-package org-ref
  :straight t
  :after ivy-bibtex ;; org-ref-ivy uses ivy-bibtex backend
  :config
  (require 'org-ref-ivy)
  ;; Set up keybinding ONLY in org-mode
  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-c ]") #'org-ref-cite-insert-ivy)))

