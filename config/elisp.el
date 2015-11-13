(defun remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))
            nil
            t))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (remove-elc-on-save)
            (eldoc-mode)
            (yas/minor-mode)
            (smartparens-mode)
            (projectile-mode)
            (rainbow-delimiters-mode)
            (company-mode)))

(push 'company-elisp company-backends)
