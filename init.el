(defconst emacs-start-time (current-time))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ))

(package-initialize)

(dolist (base-pkg '(use-package s f dash dash-functional))
  (package-install base-pkg)
  (require base-pkg))

(require 'uniquify)

(load "~/.emacs.d/autoinstall")

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

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
