(add-hook 'cider-repl-mode-hook
          (lambda ()
            (company-mode)
            (smartparens-strict-mode)
            (rainbow-delimiters-mode)
            (subword-mode)))

(add-hook 'cider-mode-hook #'eldoc-mode)

(defun my/setup-clojure ()
  (setq indent-tabs-mode nil)
  (eldoc-mode)
  (subword-mode)
  (company-mode)
  (company-quickhelp-mode)
  (projectile-mode)
  (rainbow-delimiters-mode)
  (smartparens-mode)
  (clj-refactor-mode))

(add-hook 'clojure-mode-hook 'my/setup-clojure)
