(require-package 'rainbow-delimiters)
(require-package 'projectile)
(require-package 'company)
(require-package 'smartparens)
(require-package 'company-quickhelp)

;; AUTO COMPLETE
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (eldoc-mode)
            (subword-mode)
            (smartparens-mode)
            (company-quickhelp-mode)
            (projectile-mode)
            (rainbow-delimiters-mode)
            (set (make-local-variable 'company-backends) '((company-elisp :with company-dabbrev-code)))
            (company-mode)))
