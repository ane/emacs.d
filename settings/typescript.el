(add-hook 'typescript-mode-hook
          (lambda ()
            (use-package tss)
            (eldoc-mode)
            (tss-config-default)))
