;; OCAML
(require-package 'merlin)
(require-package 'tuareg)
(require-package 'flycheck-ocaml)

(add-hook 'tuareg-mode-hook 'merlin-mode)
(with-eval-after-load 'merlin
  ;; Disable erlin's own error checking
  (setq merlin-error-after-save nil)

  (flycheck-ocaml-setup))

