(add-hook 'racket-mode-hook
          (lambda ()
            (smartparens-mode)
            (projectile-mode)
            (yas/minor-mode)
            (eldoc-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)))
