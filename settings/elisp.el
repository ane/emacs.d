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
            (setq indent-tabs-mode nil)
            (eldoc-mode)
            (subword-mode)
            (smartparens-mode)
            (smartparens-strict-mode)
            (company-quickhelp-mode)
            (projectile-mode)
            (rainbow-delimiters-mode)
            (set (make-local-variable 'company-backends) '((company-elisp :with company-dabbrev-code)))
            (company-mode)))
