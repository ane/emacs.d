(add-hook 'typescript-mode-hook
          (lambda ()
            (use-package tss)
            (auto-complete-mode)
            (use-package auto-complete-config)
            (ac-config-default)
            (tss-config-default)))
