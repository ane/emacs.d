(require-package 'rainbow-delimiters)
(require-package 'company)

;; AUTO COMPLETE
(add-hook 'emacs-lisp-mode-hook (lambda ()
																	(subword-mode)
																	(company-mode)
																	(paredit-mode)
																	(projectile-mode)
																	(rainbow-delimiters-mode)
																	(set (make-local-variable 'company-backends) '((company-elisp :with company-dabbrev-code)))
																	(company-mode)))
