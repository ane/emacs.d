(server-start)
(defconst emacs-start-time (current-time))

(add-to-list 'load-path "~/.emacs.d/vendor/use-package/")
(require 'use-package)
(setq use-package-verbose t)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(use-package-with-elapsed-timer "Initializing packages"
  (package-initialize)
  (load "~/.emacs.d/dev/dash.el/dash")
  (load "~/.emacs.d/dev/dash.el/dash-functional")
  (load "~/.emacs.d/autoinstall")

  (require 'uniquify)
  (require 'f)
  (require 's)

  ;; add load paths
  (add-to-list 'load-path "~/.emacs.d/")
  (mapc (apply-partially 'add-to-list 'load-path) (f-directories "~/.emacs.d/vendor"))
  (mapc (apply-partially 'add-to-list 'load-path) (f-directories "~/.emacs.d/projects")))

(add-to-list 'load-path "~/.emacs.d/themes/solarized")

(use-package-with-elapsed-timer "Loading interface..."
                                (load "interface")
                                (load "bindings")
                                (load custom-file))
