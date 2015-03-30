(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'merlin)
(require 'ocp-indent)



(add-hook 'tuareg-mode-hook (lambda ()
                              (setq merlin-error-after-save nil)
                              (flycheck-mode)
                              (flycheck-ocaml-setup)
                              (merlin-mode)))

(add-to-list 'company-backends 'merlin-company-backend)

(add-hook 'merlin-mode-hook 'company-mode)

