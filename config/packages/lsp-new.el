(use-package exec-path-from-shell
  :straight t
  :config (exec-path-from-shell-initialize))

(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook ((python-mode
          c-mode
          c++-mode
          js-mode
          typescript-mode 
          html-mode
          css-mode
          svelte-mode) . lsp-deferred)
  :config
  (setq lsp-enable-indentation nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-idle-delay 0.500)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-document-color-modes nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-prefer-capf t)
  (setq lsp-clients-clangd-args '("--header-insertion=never"))
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1))

(use-package svelte-mode
  :straight t
  :mode "\\.svelte\\'"
  :config
  (customize-set-variable 'svelte-basic-offset 2))
(add-hook 'svelte-mode-hook #'my/draw-only-suffix-blocks)


(use-package apheleia
  :straight t
  :config
  (apheleia-global-mode +1)

  (setq apheleia-mode-alist
        '((html-mode       . prettier)
          (css-mode        . prettier)
          (js-mode         . prettier)
          (typescript-mode . prettier)
          (tsx-mode        . prettier)
          (web-mode        . prettier)
          (svelte-mode     . svelte-formatter)
          (c-mode          . clang-format)
          (c++-mode        . clang-format)
          (python-mode     . black)
          (rust-mode       . rustfmt)
          (emacs-lisp-mode . lisp-indent))))


(use-package rust-mode
  :straight t
  :hook (rust-mode . lsp-deferred)
  :config
  (require 'lsp-rust)
  (setq rust-format-on-save nil))



;; (use-package dap-mode
;;   :straight t
;;   :after lsp-mode
;;   :commands dap-debug
;;   :config
;;   (dap-auto-configure-mode 1)
;;   (dap-ui-mode 1)
;;   (dap-tooltip-mode 1)
;;   (require 'dap-lldb)  
;;   (require 'dap-node)  
;;   (require 'dap-python)
;;   (require 'dap-codelldb)
;;   (dap-codelldb-setup)
;;   (dap-auto-configure-mode 1)
;;   ;; (dap-register-debug-template
;;   ;;  "Rust :: Dynamic Debug"
;;   ;;  (list :type "lldb"
;;   ;;        :request "launch"
;;   ;;        :name "Rust :: Dynamic Debug"
;;   ;;        :program (lambda ()
;;   ;;                   (expand-file-name
;;   ;;                    (concat "target/debug/"
;;   ;;                            (file-name-nondirectory (directory-file-name default-directory)))))
;;   ;;        :cwd (lambda () default-directory)))
;;   (dap-register-debug-template
;;    "Rust :: Debug kkkk"
;;    (list :type "lldb"
;;          :request "launch"
;;          :name "Rust :: Debug kkkk"
;;          :program "/Users/simmi/Projects/kkkk/target/debug/kkkk"
;;          :cwd "/Users/simmi/Projects/kkkk"))
;;   )

;; (with-eval-after-load 'dap-mode
;;   (require 'dap-codelldb)
;;   (dap-codelldb-setup)
;;   (set-fringe-mode 35)
;;   (setq dap-ui-breakpoint-symbol "⬤")
;;   (custom-set-faces
;;    '(dap-ui-breakpoint-face ((t (:foreground "#ff4444" :height 1.8 :weight bold))))))

;; (use-package dape
;;   :straight t
;;   :hook
;;   (after-init . dape-breakpoint-load)

;;   :custom
;;   (dape-breakpoint-global-mode +1)
;;   (dape-buffer-window-arrangement 'right)
;;   (dape-buffer-window-arrangement 'gud)
;;   (dape-info-hide-mode-line nil)

;;   :config
;;   (add-hook 'dape-display-source-hook #'pulse-momentary-highlight-one-line)
;;   (add-hook 'dape-start-hook (lambda () (save-some-buffers t t)))
;;   (add-hook 'dape-compile-hook #'kill-buffer)

;;   (with-eval-after-load 'dape
;;     (add-to-list 'dape-configs
;;                  `(rust-lldb-new
;;                    modes (rust-mode rust-ts-mode)
;;                    command "/opt/homebrew/opt/llvm/bin/lldb-dap" 
;;                    :type "lldb"
;;                    :request "launch"
;;                    :cwd (expand-file-name (locate-dominating-file default-directory "Cargo.toml"))
;;                    :initCommands ["command script import /Users/simmi/.rustup/toolchains/stable-aarch64-apple-darwin/lib/rustlib/etc/lldb_lookup.py"]
;;                    :program (lambda ()
;;                               (let* ((root (locate-dominating-file default-directory "Cargo.toml"))
;;                                      (project-name (file-name-nondirectory (directory-file-name root))))
;;                                 (expand-file-name (format "target/debug/%s" project-name) root)))
;;                    :args []))))

(use-package dap-mode
  :straight t
  :after lsp-mode
  :config
  ;; Lädt die UI-Elemente
  (dap-ui-mode 1)
  (dap-ui-controls-mode 1)
  
  ;; WICHTIG: Das sorgt dafür, dass die Variablen-Ansicht automatisch bei Pausen aufgeht
  (setq dap-auto-configure-features '(sessions locals controls tooltip))

  ;; Erfordert codelldb für Rust (dieses Paket bringt die Pretty-Printer mit)
  (require 'dap-codelldb)
  (dap-codelldb-setup)

  ;; ;; Dynamische Registrierung, damit du nicht für jedes Projekt die Pfade hartcodieren musst
  ;; (dap-register-debug-template
  ;;  "Rust :: Dynamic Run"
  ;;  (list :type "lldb"
  ;;        :request "launch"
  ;;        :name "Rust :: Dynamic Run"
  ;;        ;; :program (lambda ()
  ;;        ;;            (let* ((root (locate-dominating-file default-directory "Cargo.toml"))
  ;;        ;;                   (project-name (file-name-nondirectory (directory-file-name root))))
  ;;        ;;              (expand-file-name (format "target/debug/%s" project-name) root)))
  ;;        :program (lambda ()
  ;;                   (let* ((root (locate-dominating-file default-directory "Cargo.toml"))
  ;;                          (project-name (file-name-nondirectory (directory-file-name root))))
  ;;                     (expand-file-name (format "target/debug/%s" project-name) root)))
  ;;        :cwd (expand-file-name (locate-dominating-file default-directory "Cargo.toml"))))
  (dap-register-debug-template
   "Rust :: Debug kkkk"
   (list :type "lldb"
         :request "launch"
         :name "Rust :: Debug kkkk"
         :program "/Users/simmi/Projects/kkkk/target/debug/kkkk"
         :cwd "/Users/simmi/Projects/kkkk"))
  )

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-capf))
