(require 'cl)

;; need this so that solarized can be loaded right away
(add-to-list 'load-path "~/.emacs.d/themes/solarized")

(load-file "~/.emacs.d/packages.el")
(load-file "~/.emacs.d/interface.el")
(load-file "~/.emacs.d/bindings.el")
(load-file "~/.emacs.d/custom.el")
(load-file "~/.emacs.d/settings.el")

