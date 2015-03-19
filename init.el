
(server-start)
(defconst emacs-start-time (current-time))

(add-to-list 'load-path "~/.emacs.d/vendor/use-package/")
(require 'use-package)
(setq use-package-verbose t)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(use-package-with-elapsed-timer "Initializing packages"
  (package-initialize)
  (load "~/.emacs.d/dev/dash.el/dash")
  (load "~/.emacs.d/dev/dash.el/dash-functional")
  (load "~/.emacs.d/autoinstall")

  (require 'uniquify)
  (require 's)
  (require 'f)

  (mapc (apply-partially 'add-to-list 'load-path) (f-directories "~/.emacs.d/vendor"))
  (mapc (apply-partially 'add-to-list 'load-path) (f-directories "~/.emacs.d/projects")))

(use-package-with-elapsed-timer "Loading themes..."
  (require 'f)
  (mapc (apply-partially 'add-to-list 'load-path) (f-directories "~/.emacs.d/themes"))
  (mapc (apply-partially 'add-to-list 'custom-theme-load-path) (f-directories "~/.emacs.d/themes")))

(use-package-with-elapsed-timer "Loading interface..."
  (load "~/.emacs.d/interface")
  (load "~/.emacs.d/bindings")
  (load custom-file))

(use-package-with-elapsed-timer "Loading settings..."
  (load "~/.emacs.d/settings"))

(when window-system
  (add-hook 'after-init-hook
            `(lambda ()
               (let ((elapsed (float-time (time-subtract (current-time)
                                                         emacs-start-time))))
                 (message "Loading %s...done (%.3fs) [after-init]"
                          ,load-file-name elapsed)))
            t))
