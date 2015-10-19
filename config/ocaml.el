(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))

(add-hook 'tuareg-mode-hook (lambda ()
                              (use-package merlin)
                              (use-package ocp-indent)
                              (setq merlin-command 'opam)
                              (setq merlin-error-after-save nil)
                              (flycheck-mode)
                              (flycheck-ocaml-setup)
                              (merlin-mode)
                              (add-to-list 'company-backends 'merlin-company-backend)
                              (company-mode)))



