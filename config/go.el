;; GO
(add-hook 'go-mode-hook (lambda ()
                          (use-package go-projectile)
                          (go-eldoc-setup)
                          (flycheck-mode)
                          (subword-mode)
                          (yas/minor-mode)
                          (rainbow-delimiters-mode)
                          (setq gofmt-command "goimports")
                          (setq gofmt-show-errors nil)
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (setq company-go-show-annotation t
                                intent-tabs-mode t)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(add-hook 'speedbar-load-hook (lambda ()
                                (push ".go" speedbar-supported-extension-expressions)))
