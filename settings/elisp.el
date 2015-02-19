(require-package 'rainbow-delimiters)
(require-package 'projectile)
(require-package 'company)
(require-package 'company-quickhelp)

;; AUTO COMPLETE
(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (setq indent-tabs-mode nil)
																	(eldoc-mode)
                                  (subword-mode)
                                  (paredit-mode)
				  (company-quickhelp-mode)
                                  (projectile-mode)
                                  (rainbow-delimiters-mode)
                                  (set (make-local-variable 'company-backends) '((company-elisp :with company-dabbrev-code)))
                                  (company-mode)))
