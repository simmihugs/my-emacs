;;; my-org-table.el --- small change to org-tabel.el    -*- lexical-binding: t; -*-

;; Copyright (C) 2004-2020 Free Software Foundation, Inc.

;; Author: Simon Graetz <simongraetz@googlemail.com>
;; Keywords: -
;; Homepage: -
;;
;; This file is part of GNU Emacs.
;;
;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:

;; This file contains the table editor and spreadsheet for Org mode.

;; Watch out:  Here we are talking about two different kind of tables.
;; Most of the code is for the tables created with the Org mode table editor.
;; Sometimes, we talk about tables created and edited with the table.el
;; Emacs package.  We call the former org-type tables, and the latter
;; table.el-type tables.

;;; Code:

(require 'org-table)

;;;###autoload
(defun org-table-export (&optional file format)
  "Export table to a file, with configurable format.
Such a file can be imported into usual spreadsheet programs.

FILE can be the output file name.  If not given, it will be taken
from a TABLE_EXPORT_FILE property in the current entry or higher
up in the hierarchy, or the user will be prompted for a file
name.  FORMAT can be an export format, of the same kind as it
used when `-mode' sends a table in a different format.

The command suggests a format depending on TABLE_EXPORT_FORMAT,
whether it is set locally or up in the hierarchy, then on the
extension of the given file name, and finally on the variable
`org-table-export-default-format'."
  (interactive)
  (unless (org-at-table-p) (user-error "No table at point"))
  (org-table-align)	       ; Make sure we have everything we need.
  (let ((file (or file (org-entry-get (point) "TABLE_EXPORT_FILE" t))))
    (unless file
      (setq file (read-file-name "Export table to: "))
      (unless (or (not (file-exists-p file))
		  (y-or-n-p (format "Overwrite file %s? " file)))
	(user-error "File not written")))
    (when (file-directory-p file)
      (user-error "This is a directory path, not a file"))
    (when (and (buffer-file-name (buffer-base-buffer))
	       (file-equal-p
		(file-truename file)
		(file-truename (buffer-file-name (buffer-base-buffer)))))
      (user-error "Please specify a file name that is different from current"))
    (let ((fileext (concat (file-name-extension file) "$"))
	  (format (or format (org-entry-get (point) "TABLE_EXPORT_FORMAT" t))))
      (unless format
	(let* ((formats '("orgtbl-to-tsv" "orgtbl-to-csv" "orgtbl-to-scsv" "orgtbl-to-latex"
			  "orgtbl-to-html" "orgtbl-to-generic"
			  "orgtbl-to-texinfo" "orgtbl-to-orgtbl"
			  "orgtbl-to-unicode"))
	       (deffmt-readable
		 (replace-regexp-in-string
		  "\t" "\\t"
		  (replace-regexp-in-string
		   "\n" "\\n"
		   (or (car (delq nil
				  (mapcar
				   (lambda (f)
				     (and (string-match-p fileext f) f))
				   formats)))
		       org-table-export-default-format)
		   t t) t t)))
	  (setq format
		(org-completing-read
		 "Format: " formats nil nil deffmt-readable))))
      (if (string-match "\\([^ \t\r\n]+\\)\\( +.*\\)?" format)
	  (let ((transform (intern (match-string 1 format)))
		(params (and (match-end 2)
			     (read (concat "(" (match-string 2 format) ")"))))
		(table (org-table-to-lisp
			(buffer-substring-no-properties
			 (org-table-begin) (org-table-end)))))
	    (unless (fboundp transform)
	      (user-error "No such transformation function %s" transform))
	    (let (buf)
	      (with-current-buffer (find-file-noselect file)
		(setq buf (current-buffer))
		(erase-buffer)
		(fundamental-mode)
		(insert (funcall transform table params) "\n")
		(save-buffer))
	      (kill-buffer buf))
	    (message "Export done."))
	(user-error "TABLE_EXPORT_FORMAT invalid")))))

;;;###autoload
(defun orgtbl-to-scsv (table params)
  "Convert the orgtbl-mode table to CSV material.
This does take care of the proper quoting of fields with comma or quotes."
  (orgtbl-to-generic table
		     (org-combine-plists '(:sep ";" :fmt org-quote-csv-field)
					 params)))
(provide 'my-org-table)
;;; my-org-table.el ends here
