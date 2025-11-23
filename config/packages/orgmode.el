(use-package ivy-bibtex
  :straight t
  :defer t
  :custom
  (bibtex-completion-bibliography
   '("~/Documents/org/thesis/bib-refs.bib"))
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


(use-package org-ref
  :straight t
  :after ivy-bibtex
  )


(use-package org
  :straight (:type built-in)
  :init
  (require 'org-ref-ivy)
  :config 
  (defun org-insert-img-with-attrs ()
    "Prompt for image file from ./img/, insert ATTR lines and image link for org export."
    (interactive)
    (let* ((img-dir (expand-file-name "img/" default-directory))
           (img-file (read-file-name "Select image: " img-dir nil t nil
                                     (lambda (f) (string-match-p (image-file-name-regexp) f))))
           (rel-link (concat "img/" (file-name-nondirectory img-file))))
      (insert "#+ATTR_LATEX: :width 0.5\\textwidth :center t\n")
      (insert "#+ATTR_HTML: :style width:50%;display:block;margin-left:auto;margin-right:auto;\n")
      (insert (format "[[file:%s]]\n" rel-link))))

  ;; Example key binding (you can change to your preference)
  (define-key org-mode-map (kbd "C-c i") #'org-insert-img-with-attrs)


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

  (setq org-file-apps
        '(("\\.pdf\\'" . "evince %s")
          (auto-mode . emacs)))


  :hook
  (org-mode . (lambda ()
                (local-set-key (kbd "<f5>") 'org-export-latex-pdf-and-save)))
  (org-mode . (lambda ()
                (local-set-key (kbd "C-c ]") 'org-ref-cite-insert-ivy))))

