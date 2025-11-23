(use-package exec-path-from-shell
  :straight t
  :config (exec-path-from-shell-initialize))

(use-package go-mode
  :straight t
  :init
  (setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/go/bin")))
  (setq exec-path (append exec-path (list (expand-file-name "~/go/bin"))))
  :hook
  (go-mode . (lambda ()
               (setq tab-width 4)))
  (go-mode . (lambda ()
               (add-hook 'before-save-hook #'lsp-format-buffer nil t))))

(use-package lsp-mode
  :straight t
  :init
  (setq lsp-format-on-save t)
  :hook ((python-mode     . lsp-deferred)
	 (c-mode          . lsp-deferred)
	 (js-mode         . lsp-deferred)
	 (typescript-mode . lsp-deferred)
	 (html-mode       . lsp-deferred)
	 (css-mode        . lsp-deferred)
	 (rust-mode       . lsp-deferred)
         (go-mode         . lsp-deferred)
         (lsp-mode        . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :bind (("C-c C-f" . lsp-format-buffer)
	 )
  :config
  (setq lsp-clients-clangd-args
	'("--header-insertion=never"))
  (setq lsp-enable-file-watchers nil)

  ;;; Like this?

  (setq lsp-prefer-capf t)
  (setq company-backends '(company-capf))
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1)


  ;; (setq lsp-rust-analyzer-linked-projects
  ;;       '("/home/simmi/Projects/pomodoro_player_gtk/Cargo.toml"))
  )

(use-package typescript-mode
  :straight t)

(use-package lsp-ui
  :straight t
  :commands (lsp-ui-mode)
  :custom
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-show-code-actions nil)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-delay 0)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory nil)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-delay 0.2)
  (lsp-ui-imenu-window-width 0)
  (lsp-ui-imenu--custom-mode-line-format nil)
  :hook (lsp-mode . lsp-ui-mode))

(setq python-indent-guess-indent-offset nil)
(setq python-indent-offset 4)

(use-package pyvenv
  :straight t
  :init
  (pyvenv-mode 1))

(add-hook
 'inferior-python-mode-hook
 (lambda ()
   (define-key inferior-python-mode-map (kbd "C-l") 'comint-clear-buffer)))


(use-package lsp-pyright
  :straight t
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

(use-package lsp-java
  :straight t
  :after lsp-mode
  :hook (java-mode . lsp)
  :config
  (setq lsp-java-java-path "/usr/lib/jvm/java-21-openjdk-amd64/bin/java")
  ;; Example of setting workspace dir if needed
  ;; (setq lsp-java-workspace-dir "~/.emacs.d/workspace/")
  )



(use-package flymake-python-pyflakes
  :straight t
  :config
  (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
  (setq flymake-python-pyflakes-executable "python3")
  (setq flycheck-flake8-error-format '("%s:%l:%c: %t%n %s"))
  (setq flycheck-flake8-args '("-m" "flake8")))

(use-package format-all
  :straight t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci"))
                  ("Python" (black)))))

(defun my/set-python-venv ()
  "Set the python environment."
  (interactive)
  (let ((default-venv-path (expand-file-name "venv" default-directory))
        venv-path
        (python-buffer (get-buffer "*Python*")))
    (if (file-directory-p default-venv-path)
      (setq venv-path default-venv-path)
      (setq venv-path
	    (expand-file-name
	     "venv"
	     (read-directory-name "Path to virtual environment root: "))))
    (when (not (file-directory-p venv-path))
      (error "Invalid virtual environment directory: %s" venv-path))
    (setenv "VIRTUAL_ENV" venv-path)
    (setenv "PATH" (concat (expand-file-name "bin" venv-path) ":" (getenv "PATH")))
    (setq exec-path (cons (expand-file-name "bin" venv-path) exec-path))
    (setq python-shell-virtualenv venv-path)
    (message (format "Set Python venv: %s" venv-path))
    (when python-buffer
      (with-current-buffer python-buffer
        (python-shell-restart)))))

;(global-set-key (kbd "C-c s v") 'my/set-python-venv)


(use-package rust-mode
  :straight t
  :config
  (require 'rust-rustfmt)
  (require 'lsp-rust)
  (setq rust-format-on-save t))

(use-package js2-mode
  :straight t
  :config
  (setq-default js2-basic-offset 2)
  (setq-default indent-tabs-mode nil))

(use-package prettier-js
  :straight t
  :hook ((js-mode . prettier-js-mode)
         (web-mode . prettier-js-mode))
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js-mode))
  (add-hook 'js-mode-hook 'js2-minor-mode)  
  (add-hook 'before-save-hook 'prettier-js-mode))


(use-package lsp-haskell
  :straight t)

(use-package haskell-mode
  :straight t
  :hook (haskell-mode . lsp-deferred)
  :bind (:map haskell-mode-map
         ("C-l" . haskell-interactive-mode-clear)))

;; lean4
(use-package lean4-mode
  :straight (lean4-mode
	     :type git
	     :host github
	     :repo "leanprover/lean4-mode"
	     :files ("*.el" "data"))
  :commands (lean4-mode))

(use-package cc-mode
  :straight nil
  :config
  (c-add-style "microsoft"
               '("stroustrup"
                 (c-offsets-alist
                  (innamespace . -)
                  (inline-open . 0)
                  (inher-cont . c-lineup-multi-inher)
                  (arglist-cont-nonempty . +)
                  (template-args-cont . +))))
  (setq c-default-style "microsoft")

  (defun format-after-save()
    (when (eq major-mode 'c++-mode)
      (lsp-format-buffer)))
  (add-hook 'after-save-hook #'format-after-save))

(use-package cmake-mode
  :straight t
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'"         . cmake-mode))
  :bind (:map cmake-mode-map
         ("C-c d" . cmake-help))
  :config
  )

(use-package tempo
  :ensure nil
  :after cc-mode
  :hook ((c-mode . c-mode-tempo-setup)
         (c++-mode . c++-mode-tempo-setup))
  :config
  (defvar c-tempo-tags nil)
  (defvar c++-tempo-tags nil)

  (defun c-mode-tempo-setup ()
    (tempo-use-tag-list 'c-tempo-tags))
  (defun c++-mode-tempo-setup ()
    (tempo-use-tag-list 'c-tempo-tags)
    (tempo-use-tag-list 'c++-tempo-tags))

  (tempo-define-template "c-ifndef"
                         '("#ifndef " (P "ifndef-clause: " clause) > n
                           "#define " (s clause) n> p n
                           "#endif // " (s clause) n>
                           )
                         "ifndef"
                         "Insert #ifndef #define #endif directives"
                         'c-tempo-tags)
  (tempo-define-template "c-main"
                         '("int main(int argc, char* argv[]) {" > n>
                           p n
                           "}" > n>
                           )
                         "main"
                         "Insert a main function"
                         'c-tempo-tags))

