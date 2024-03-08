(use-package github-dark-vscode-theme
  :straight (github-dark-vscode :type git
				:host github
				:repo "simmihugs/github-dark-theme")
  :config (load-theme 'github-dark-vscode t))
