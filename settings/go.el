;; GO
(add-hook 'go-mode-hook (lambda ()
													(go-eldoc-setup)
													(require 'go-projectile)
													(setq gofmt-command "goimports")
													(add-hook 'before-save-hook 'gofmt-before-save)
													(setq company-go-show-annotation t)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
