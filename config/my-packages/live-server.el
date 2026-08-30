(use-package live-server
  :straight (live-server :type git :host github :repo "simmihugs/live-server")
  :bind (("C-c l s" . live-server-start)
         ("C-c l k" . live-server-stop)
         ("C-c l r" . live-server-restart)
         ("C-c l c" . live-server-copy-url)
         ("C-c l o" . live-server-open-browser))
  :config
  ;; set live-server Cargo-Binary in case it is a an unsual place
  (setq live-server-command "~/.cargo/bin/live-server"))
