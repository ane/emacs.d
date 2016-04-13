(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))

(add-hook 'slime-mode-hook
          (lambda ()
            (company-mode)
	    (flycheck-mode)
            (rainbow-delimiters-mode)
            (paredit-mode)
            (yas/minor-mode)))
