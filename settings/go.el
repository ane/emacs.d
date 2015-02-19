(require-package 'flycheck)
(require-package 'projectile)
(require-package 'go-eldoc)
(require-package 'go-projectile)
(require-package 'company)
(require-package 'company-go)
(require-package 'rainbow-delimiters)
;; GO
(add-hook 'go-mode-hook (lambda ()
			 (go-eldoc-setup)
			 (projectile-mode)
			 (flycheck-mode)
			 (subword-mode)
			 (rainbow-delimiters-mode)
			 (require 'go-projectile)
			 (setq gofmt-command "goimports")
			 (add-hook 'before-save-hook 'gofmt-before-save)
			 (setq company-go-show-annotation t)
			 (set (make-local-variable 'company-backends) '(company-go))
			 (company-mode)))
