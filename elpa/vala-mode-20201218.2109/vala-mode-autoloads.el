;;; vala-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "vala-mode" "vala-mode.el" (0 0 0 0))
;;; Generated autoloads from vala-mode.el

(add-to-list 'auto-mode-alist '("\\.vala\\'" . vala-mode))

(add-to-list 'auto-mode-alist '("\\.vapi\\'" . vala-mode))

(c-add-style "vala" '("linux" (c-comment-only-line-offset 0 . 0) (c-offsets-alist (func-decl-cont . ++))))

(autoload 'vala-mode "vala-mode" "\
Major mode for editing Vala code.
Based on CC Mode.

The hook `c-mode-common-hook' is run with no args at mode
initialization, then `vala-mode-hook'.

Key bindings:
\\{vala-mode-map}" t nil)

(register-definition-prefixes "vala-mode" '("c-filter-ops" "vala-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; vala-mode-autoloads.el ends here
