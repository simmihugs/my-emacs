;;; Commentary:
;; This file defines a function to send the current Emacs buffer as an email
;; attachment using the 'sendmail' command. It interactively prompts the user
;; for the recipient's email address, subject, and an optional message body.
;; The current buffer's content is saved to a temporary file, which is then
;; attached to the email.
;;; Code:

(defun my/send-buffer-as-email ()
  "Send the current buffer as an email attachment.
Interactively prompts for recipient, subject, and message body.
The buffer is saved to a temporary file for attachment."
  (interactive)
  (let* ((recipient (read-string "Recipient Email: "))
         (subject (read-string "Subject: "))
         (message (read-string "Message Body (optional): "))
         (temp-dir (temporary-file-directory))
         (temp-file (expand-file-name "emacs-email-attachment" temp-dir))
         (buffer-name (buffer-name))
         (content-type "text/plain")
         (sendmail-command "sendmail"))

    (unless (executable-find sendmail-command)
      (error "sendmail not found. Please ensure it is in your PATH."))

    (with-current-buffer (current-buffer)
      (write-file temp-file))

    (unwind-protect
        (progn
          (message "Sending email...")
          (let ((process (start-process "email-process" nil sendmail-command "-t")))
            (process-send-string process
                                 (concat "To: " recipient "\n"
                                         "Subject: " subject "\n"
                                         "MIME-Version: 1.0\n"
                                         "Content-Type: multipart/mixed; boundary=\"emacs-boundary\"\n\n"
                                         "--emacs-boundary\n"
                                         "Content-Type: text/plain; charset=utf-8\n\n"
                                         message "\n"
                                         "--emacs-boundary\n"
                                         "Content-Type: " content-type "; name=\"" buffer-name "\"\n"
                                         "Content-Disposition: attachment; filename=\"" buffer-name "\"\n"
                                         "Content-Transfer-Encoding: base64\n\n"
                                         (with-temp-buffer
                                           (insert-file-contents-literally temp-file)
                                           (base64-encode-string (buffer-string)))
                                         "\n"
                                         "--emacs-boundary--\n"
                                         ))
            (process-send-eof process)
            (while (accept-process-output process 2))
            (message "Email sent to %s with subject: %s" recipient subject)))

      (when (file-exists-p temp-file)
        (delete-file temp-file)))))

(provide 'my/send-buffer-as-email)

