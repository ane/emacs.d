(defun scheme-module-indent (state indent-point normal-indent) 0)

(add-hook 'geiser-mode-hook
          (lambda ()
            (setq-local company-idle-delay 1)
            (put 'module 'scheme-indent-function 'scheme-module-indent)
            (rainbow-delimiters-mode)
            (paredit-mode)
            (eldoc-mode)
            (company-mode)))

(add-hook 'geiser-repl-mode-hook
          (lambda ()
            (rainbow-delimiters-mode)
            (company-mode)
            (paredit-mode)))
