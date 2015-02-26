(require 'cl)

;; need this so that solarized can be loaded right away
(add-to-list 'load-path "~/.emacs.d/themes/solarized")
(load "~/.emacs.d/packages")

(load "~/.emacs.d/interface")
(load "~/.emacs.d/bindings")
(load "~/.emacs.d/custom")
(load "~/.emacs.d/settings")

