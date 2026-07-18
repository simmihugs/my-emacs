(use-package eglot
  :ensure nil
  :defer t
  :hook ((rust-ts-mode . eglot-ensure)
         (rust-mode    . eglot-ensure)
         (python-mode  . eglot-ensure)
         (js-mode      . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (tsx-mode     . eglot-ensure)
         (svelte-mode  . eglot-ensure)
         (css-mode     . eglot-ensure)
         (html-mode    . eglot-ensure)
         (c-mode       . eglot-ensure)
         (c++-mode     . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               `((rust-mode rust-ts-mode) . ("rust-analyzer"))
               `((python-mode) . ("pylsp"))
               `((js-mode typescript-mode tsx-mode) . ("typescript-language-server" "--stdio"))
               `((svelte-mode) . ("svelteserver" "--stdio"))
               `((php-mode) . ("intelephense" "--stdio"))
               `((c-mode c++-mode) . ("clangd"))))

(use-package apheleia
  :straight t
  :defer t
  :init
  (apheleia-global-mode +1)
  :config
  (setf (alist-get 'prettier-svelte apheleia-formatters)
        '(npx "prettier" 
              "--parser" "svelte" 
              "--plugin" "prettier-plugin-svelte"
              filepath))
  (setq apheleia-mode-alist
        '((html-mode       . prettier)
          (css-mode        . prettier)
          (js-mode         . prettier)
          (typescript-mode . prettier)
          (tsx-mode        . prettier)
          (web-mode        . prettier)
          (svelte-mode     . prettier-svelte)
          (c-mode          . clang-format)
          (c++-mode        . clang-format)
          (emacs-lisp-mode . lisp-indent))))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-capf))

(use-package dap-mode
  :straight t
  :defer t
  :commands dap-debug
  :config
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (require 'dap-lldb)  
  (require 'dap-node)  
  (require 'dap-python))
