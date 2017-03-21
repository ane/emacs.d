(defconst emacs-start-time (current-time))
(load "~/.emacs.d/bootstrap")
(load "~/.emacs.d/packages")
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
