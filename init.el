(defconst emacs-start-time (current-time))


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ))
(package-initialize)

(dolist (base-pkg '(use-package s f dash dash-functional))
  (when (not (package-installed-p base-pkg))
    (package-refresh-contents)
    (package-install base-pkg))
  (require base-pkg))

(require 'uniquify)

(load "~/.emacs.d/autoinstall")

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
(put 'japanese-hiragana-region 'disabled t)
