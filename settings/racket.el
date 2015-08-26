(sp-local-pair 'racket-mode "'" nil :actions nil)

(sp-local-pair 'racket-mode "(" nil :bind "C-(")

(add-hook 'racket-mode-hook
          (lambda ()
            (add-to-list 'sp--lisp-modes 'racket-mode)
            (smartparens-strict-mode)
            (local-unset-key ")")
            (local-unset-key "[")
            (local-unset-key "}")
            (local-unset-key "]")
            (projectile-mode)
            (yas/minor-mode)
            (eldoc-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)))
