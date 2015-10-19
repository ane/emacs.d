(add-hook 'ruby-mode-hook
          (lambda ()
            (company-mode)
            (add-to-list 'company-backends 'company-robe)
            (robe-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)
            (eldoc-mode)))
