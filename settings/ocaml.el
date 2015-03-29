(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'merlin)


(with-eval-after-load 'merlin
  ;; Disable Merlin's own error checking
  (setq merlin-error-after-save nil)

  ;; Enable Flycheck checker
  (flycheck-ocaml-setup))


(add-hook 'tuareg-mode-hook (lambda ()
                              (flycheck-mode)
                              (merlin-mode)))

(add-to-list 'company-backends 'merlin-company-backend)

(add-hook 'merlin-mode-hook 'company-mode)

