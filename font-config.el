;; Define the list of fonts and their heights
(defvar my/fonts
  '(("EnvyCodeRNerdFontPropo" . 130)
    ("D2CodingLigatureNerdFont" . 140)
    ("FantasqueSansMNerdFont" . 140)
    ("IBM Plex mono" . 130)
    ("MonaspaceArgonFrozen" . 130)
    ("IntoneMono Nerd Font" . 110)    
    ("MonaspaceXenonFrozen" . 130)
    ("RecMonoSmCasual Nerd Font" . 130)
    ("Monaspace Radon Frozen" . 130)   
    ("0xProto Nerd Font" . 110)
    ("Roboto Mono" . 110)
    ("Chivo Mono" . 110)
    ("SomeType Mono" . 120)
    ("Iosevka NF" . 100)
    ("cascadia code" . 120)
    ("consolas" . 120))
  "List of preferred fonts and their heights.")

;; Define the font-setting function
(defun my/setfont (fonts)
  "Set the first available font from FONTS, a list of (NAME . HEIGHT)."
  (catch 'found
    (dolist (font fonts)
      (when (find-font (font-spec :name (car font)))
        (set-face-attribute 'default nil :font (car font) :height (cdr font))
        (throw 'found t)))
    (message "no font found")))

   ;; Use the function with your font list
(my/setfont my/fonts)


(defun my/select-and-set-font ()
  "Interactively select a font from `my/fonts` and set it.
  This function prompts the user with a list of font names from the `my/fonts`
  variable. Once a font is selected, it finds the associated height and applies
  both to the 'default' face."
  (interactive)
  ;; Get a list of just the font names from the my/fonts alist,
  ;; pre-filtered to include only fonts that are actually available.
  (let* ((font-names (cl-remove-if-not
                       (lambda (font-name) (find-font (font-spec :name font-name)))
                       (mapcar 'car my/fonts)))
         ;; Prompt the user for a font name using `completing-read`.
         ;; The font-names list provides the completion candidates.
         (chosen-font-name (completing-read "Select a font: " font-names nil t)))
    ;; Check if a font was actually chosen (e.g., the user didn't cancel)
    (when chosen-font-name
      ;; Find the entry for the chosen font in the my/fonts alist
      (let ((font-entry (assoc chosen-font-name my/fonts)))
        ;; Check if a valid entry was found
        (when font-entry
          ;; Extract the font name and height from the entry
          (let ((font-name (car font-entry))
                (font-height (cdr font-entry)))
            ;; Apply the new font and height
            (set-face-attribute 'default nil :font font-name :height font-height)
            ;; Provide a message to the user that the font was set
            (message "Font set to %s with height %s" font-name font-height)))))))

(global-set-key (kbd "C-c f") 'my/select-and-set-font)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (my/setfont my/fonts))))
