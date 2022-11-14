;;; my-reformate-org-table.el --- Allows to reformate stuff into org tables  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  

;; Author:  <Simon@DESKTOP-344ORJS>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(eval-when-compile (require 'subr-x))
(defun org/find-index(data word)
  (let ((answer -1)
	(counter 0)
	(found nil))
    (while data
      (if (not found)
	  (if (string= (car data) word) (progn (setq answer counter) (setq found t)) nil) nil)
      (setq data (cdr data))
      (setq counter (+ 1 counter)))
    answer))

(defun org/line-type(line index1)
  (cond
   ((string-match "Derzeit" (nth index1 line)) "Block")
   ((string-match "WERBUNG" (nth index1 line)) "Werbung")
   ((string-match "UHD" (nth index1 line)) "Trailer")
   ((string-match "Nachklappe" (nth index1 line)) "Trailer")
   ((string-match "SG2QCNYB" (nth index1 line)) "Trailer")
   ((string-match "SG2QB7GE" (nth index1 line)) "Trailer")
   ((string-match "NK_Maschinen_der_Superlative_NACHKLAPPE_MOTIV_alg_DT2PGK5Q_HD_Deutsch" (nth index1 line)) "Trailer")
   ((string-match "Sat 1 UHD Signation Bälle" (nth index1 line)) "Trailer")
   ("Programm")))

(defun org/lookup-logo(number)
  (cond
   ((= 1 number) "Astra links")
   ((= 2 number) "Astra rechts")
   ((= 3 number) "HD Plus links")
   ((= 4 number) "HD Plus rechts")
   ((= 5 number) "Ran Live")
   ((= 6 number) "Ran Fighting")
   ((= 7 number) "K1_RUN")
   ((= 8 number) "P7_RUN")
   ((= 9 number) "HR Menorca")
   ((= 10 number) "Pro7 Ran Clean")
   ((= 11 number) "RTLZWEI_UHD")
   ((= 13 number) "P7_MAXX_UHD")   
   ((= 14 number) "K1_DOKU_UHD")
   ((= 15 number) "P7_MAXX_RAN_UHD")
   ((= 16 number) "Sat.1 UHD ranBUNDESLIGA LIVE")
   ((= 17 number) "SAT.1 - Gold UHD")
   (t (string-join (list "Unknown logo with number: " (number-to-string number))))))

(defun org/title(line index-title index-clipnumber)
  (let* ((title  (string-trim (replace-regexp-in-string "- UHD1_WERBUNG-01" "UHD1_WERBUNG-01" (nth index-title line))))
	 (clipnumber (string-trim (nth index-clipnumber line)))
	 (dranbleiben (concat title " (Dranbleiben)"))
	 (pausentafel (concat title " (Pausentafel)")))
    (cond
     ((string= "P7S1UHD_LOOP_DRANBLEIBEN_15MIN_UHD.mxf" clipnumber) dranbleiben)
     ((string= "PRO7_HDPLUS_PAUSENTAFEL_15_MIN_UHD.mxf" clipnumber) pausentafel)
     (t title))))

(defun org/line-to-str(line indices)
  (let* ((index-title        (nth 0 indices))
	 (index-logo-nr      (nth 1 indices))
	 (index-logo         (nth 2 indices))   
	 (index-seriennummer (nth 3 indices))
	 (index-clipnummer   (nth 4 indices))
	 (index-sendebeginn  (nth 5 indices))
	 (index-sendeende    (nth 6 indices))
	 (index-sendedauer   (nth 7 indices))
	 (typ                (org/line-type line index-title))
	 (title              (org/title line index-title index-clipnummer))
	 (clipnumber         (string-trim (nth index-clipnummer line)))
	 (sendedauer         (string-trim (nth index-sendedauer line)))
	 (sendeende          (string-trim (nth index-sendeende line)))
	 (sendebeginn        (string-trim (nth index-sendebeginn line)))
	 (logo               (org/logo line index-logo-nr index-logo))
	 (seriennummer       (string-trim (nth index-seriennummer line))))
    ((lambda (s) (concat "|" s "\n"))
     (string-join (list typ title logo seriennummer sendebeginn sendeende sendedauer) "|"))))

(defun org/logo(line logo-nr logo)
  (let* ((has-logo (string-to-number (string-trim (nth logo line))))
	 (logo (org/lookup-logo (string-to-number (string-trim (nth logo-nr line))))))
    (cond
     ((= 1 has-logo) logo)
     (t ""))))

(defun org/insert-timestamp()
  (interactive)
  (insert (org/timestamp)))

(defun org/timestamp()
  (format-time-string "%d-%m-%Y__%H-%M"))

(defun org/insert-header()
  (interactive)
  (let ((time (org/timestamp)))
    (insert
     (concat "* " time "\n"
	     "  :PROPERTIES:\n"
	     "  :TABLE_EXPORT_FILE: " time ".csv\n"
	     "  :TABLE_EXPORT_FORMAT: orgtbl-to-scsv\n"
	     "  :END:\n\n"))))

(defun org/reformat-to-table(start end)
  (interactive "r")
  (let* ((data (mapcar '(lambda (s) (split-string s "\t")) (split-string (buffer-substring start end) "\n")))
	 (typ         "Typ")
	 (serientitel "Serientitel")
	 (seriennummer "Nummer")	     
	 (sendebeginn "Sendebeginn")
	 (sendeende   "Sendeende")
	 (sendedauer  "Sendedauer")
	 (clipnummer  "ClipNummer")

	 (index-title        (1+ (org/find-index (car data) serientitel)))
	 (index-logo-nr      (org/find-index (car data) "LogoNr"))
	 (index-logo         (org/find-index (car data) "Logo"))
	 (index-seriennummer (org/find-index (car data) seriennummer))
	 (index-clipnummer   (org/find-index (car data) clipnummer))
	 (index-sendebeginn  (org/find-index (car data) sendebeginn))
	 (index-sendeende    (org/find-index (car data) sendeende))
	 (index-sendedauer   (org/find-index (car data) sendedauer))

	 (indices (list index-title       
			index-logo-nr     
			index-logo        
			index-seriennummer
			index-clipnummer  
			index-sendebeginn 
			index-sendeende   
			index-sendedauer))

	 (text (format "  |%s|%s|%s|%s|%s|%s|%s|\n" typ serientitel "Logo" seriennummer sendebeginn sendeende sendedauer)))
    (setq data (cdr data))
    (dotimes (number (1-(length data)))
      (if (or
	   (string-match "Secondary" (nth index-title (car data)))
	   (string-match "Block"     (nth index-title (car data)))
	   (string-match "Adbreak"   (nth index-title (car data)))		
	   (string-match "New slot"  (nth index-title (car data))))
	  nil
	(setq text (string-join (list text (org/line-to-str (car data) indices)))))
      (setq data (cdr data)))
    (kill-region start end)
    (org/insert-header)
    (insert text)
    (org-table-align)))


(provide 'my-reformate-org-table)
;;; my-reformate-org-table.el ends here
