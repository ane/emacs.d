
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (eldoc-mode)
            (yas-minor-mode-on)
            (projectile-mode)
            (rainbow-delimiters-mode)
            (rainbow-mode)
            (company-mode)
            (paredit-mode)
            (set (make-local-variable 'company-backends) '(company-capf))))
