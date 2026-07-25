(use-package dape
  :straight t
  :hook
  (after-init . dape-breakpoint-load)

  :custom
  (dape-breakpoint-global-mode +1)
  (dape-buffer-window-arrangement 'right)
  (dape-buffer-window-arrangement 'gud)
  (dape-info-hide-mode-line nil)

  :config
  (add-hook 'dape-display-source-hook #'pulse-momentary-highlight-one-line)
  (add-hook 'dape-start-hook (lambda () (save-some-buffers t t)))
  (add-hook 'dape-compile-hook #'kill-buffer)

  (defun find-pid()
    (let* ((cargo-dir (locate-dominating-file default-directory "Cargo.toml"))
           (root-dir (expand-file-name ".." cargo-dir))
           (app-name (file-name-nondirectory (directory-file-name root-dir)))
           (pid-raw (shell-command-to-string (format "pgrep -f target/debug/%s" app-name)))
           (pid-str (car (split-string pid-raw "\n" t)))
           (pid (if pid-str
                  (string-to-number pid-str)
                  (read-number (format "Process '%s' not found. Enter PID manually: " app-name)))))
      pid))

  
  (with-eval-after-load 'dape
    (add-to-list 'dape-configs
                 `(rust-lldb-new
                   modes (rust-mode rust-ts-mode)
                   command "/opt/homebrew/opt/llvm/bin/lldb-dap" 
                   :type "lldb"
                   :request "launch"
                   :cwd (expand-file-name (locate-dominating-file default-directory "Cargo.toml"))
                   :program (lambda ()
                              (let* ((root (locate-dominating-file default-directory "Cargo.toml"))
                                     (project-name (file-name-nondirectory (directory-file-name root))))
                                (expand-file-name (format "target/debug/%s" project-name) root)))
                   :args [])))

  (with-eval-after-load 'dape
    (add-to-list 'dape-configs
                 `(lldb-attach-tauri
                   modes (rust-mode rust-ts-mode)
                   command "/opt/homebrew/opt/llvm/bin/lldb-dap"
                   :type "lldb"
                   :request "attach"
                   :pid find-pid
                   :program (lambda ()
                              (let* ((cargo-dir (locate-dominating-file default-directory "Cargo.toml"))
                                     (root-dir (expand-file-name ".." cargo-dir))
                                     (app-name (file-name-nondirectory (directory-file-name root-dir))))
                                (expand-file-name (format "src-tauri/target/debug/%s" app-name) root-dir))))))

  (with-eval-after-load 'dape
    (add-to-list 'dape-configs
                 `(pid--lldb-attach-tauri
                   modes (rust-mode rust-ts-mode)
                   command "/opt/homebrew/opt/llvm/bin/lldb-dap" 
                   :type "lldb"
                   :request "attach"
                   :pid (lambda () (read-number "Attach to PID: "))
                   :cwd (expand-file-name (locate-dominating-file default-directory "Cargo.toml"))
                   :program (lambda ()
                              (let* ((root (locate-dominating-file default-directory "Cargo.toml"))
                                     (project-name (file-name-nondirectory (directory-file-name root))))
                                (expand-file-name (format "target/debug/%s" project-name) root)))
                   :args [])))


  (with-eval-after-load 'dape
    (fringe-mode '(25 . 0))
    (let ((my-red "#e05e8e"))
      (set-face-attribute 'dape-breakpoint-face nil :foreground my-red :background nil))

    (let ((large-circle-bitmap (vector #x0000 #x03C0 #x0FF0
                                       #x1FF8 #x3FFA #x3FFA
                                       #x7FFF #x7FFF #x7FFF
                                       #x7FFF #x3FFA #x3FFA
                                       #x1FF8 #x0FF0 #x03C0
                                       #x0000)))
      (define-fringe-bitmap 'breakpoint large-circle-bitmap 16 16)
      (define-fringe-bitmap 'dape-breakpoint large-circle-bitmap 16 16))))

