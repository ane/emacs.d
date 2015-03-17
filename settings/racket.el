(add-hook 'racket-mode-hook
          (lambda ()
            (smartparens-strict-mode)
            (projectile-mode)
            (eldoc-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)))
