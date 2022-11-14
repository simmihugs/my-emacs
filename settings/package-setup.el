(setq package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/") 
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("org" . "http://orgmode.org/elpa/")))

(condition-case nil
    (require 'use-package)
  (file-error
   (package-initialize)
   (package-refresh-contents)
   (package-install 'use-package)
   (require 'use-package)))
(setq use-package-always-ensure t)
(setq ng-straight-bootstrap-at-startup t)
