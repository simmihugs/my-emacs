(use-package docker
  :straight t
  :config
  (add-to-list
   'treesit-language-source-alist
   '(dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile")))
