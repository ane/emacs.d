(add-hook 'geiser-mode-hook
          (lambda ()
            (rainbow-delimiters-mode)
            (paredit-mode)
            (eldoc-mode)
            (yasnippet-mode)
            (company-mode)))
