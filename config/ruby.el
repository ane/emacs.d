(add-hook 'ruby-mode-hook
          (lambda ()
            (use-package ruby-block)
            (company-mode)
            (add-to-list 'company-backends 'company-robe)
            (yard-mode)
            (robe-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)
            (eldoc-mode)))

(add-hook 'speedbar-mode-hook
          (lambda()
            (speedbar-add-supported-extension "\\.rb")
            (speedbar-add-supported-extension "\\.ru")
            (speedbar-add-supported-extension "\\.erb")
            (speedbar-add-supported-extension "\\.rjs")
            (speedbar-add-supported-extension "\\.rhtml")
            (speedbar-add-supported-extension "\\.rake")))
