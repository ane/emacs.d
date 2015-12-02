(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

(add-hook 'slime-mode-hook
          (lambda ()
            (company-mode)
            (message "Hello!!!")
            (rainbow-delimiters-mode)
            (paredit-mode)
            (yas/minor-mode)))
