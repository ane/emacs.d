(server-start)
(defconst emacs-start-time (current-time))


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa-stable" . "http://stable.melpa.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
			 ("elpy" . "http://jorgenschaefer.github.io/packages/")
			 ("org" . "http://orgmode.org/elpa/")))
(package-initialize)
(when (or (not (package-installed-p 'dash))
	  (not (package-installed-p 'dash-functional))
	  (not (package-installed-p 'use-package)))
  (package-refresh-contents)
  (package-install 'dash)
  (package-install 'dash-functional)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)
(require 'dash)
(require 'dash-functional)

(load "~/.emacs.d/autoinstall")

(require 'uniquify)
(require 's)
(require 'f)

(mapc (apply-partially 'add-to-list 'load-path) (f-directories "~/.emacs.d/vendor"))
(mapc (apply-partially 'add-to-list 'load-path) (f-directories "~/.emacs.d/projects"))

(require 'f)
(mapc (apply-partially 'add-to-list 'load-path) (f-directories "~/.emacs.d/themes"))
(mapc (apply-partially 'add-to-list 'custom-theme-load-path) (f-directories "~/.emacs.d/themes"))

(load "~/.emacs.d/interface")
(load "~/.emacs.d/bindings")
(load custom-file)

(load "~/.emacs.d/settings")

(when window-system
  (add-hook 'after-init-hook
	    `(lambda ()
	       (let ((elapsed (float-time (time-subtract (current-time)
							 emacs-start-time))))
		 (message "Loading %s...done (%.3fs) [after-init]"
			  ,load-file-name elapsed)))
	    t))
