(require-package 'smartparens)
(require-package 'rainbow-delimiters)
(require-package 'company)

;; AUTO COMPLETE
(add-hook 'emacs-lisp-mode-hook (lambda ()
																	(subword-mode)
																	(company-mode)
																	(projectile-mode)
																	(rainbow-delimiters-mode)
																	(smartparens-mode)
																	(set (make-local-variable 'company-backends) '((company-elisp :with company-dabbrev-code)))
																	(company-mode)))
