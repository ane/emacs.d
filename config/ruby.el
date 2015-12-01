(add-hook 'ruby-mode-hook
          (lambda ()
            (rvm-use-default)
            (company-mode)
            (add-to-list 'company-backends 'company-robe)
            (robe-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)
            (projectile-rails-mode)
            (eldoc-mode)))

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
