(add-hook 'js-mode-hook
          (lambda ()
            (rainbow-delimiters-mode)
            (eldoc-mode)
            (flycheck-mode)
            (tern-mode t)
            (company-mode)
            (add-to-list 'company-backends 'company-tern)))

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(flycheck-add-mode 'javascript-eslint 'web-mode)

(add-hook 'web-mode-hook
          (flycheck-mode))

(add-hook 'json-mode-hook
          (lambda ()
            (flycheck-mode)))
