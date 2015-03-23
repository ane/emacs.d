(use-package company)

(push 'company-capf company-backends)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'projectile-mode)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-mode)

(require 'clojure-mode-extra-font-locking)
(cljr-add-keybindings-with-prefix "C-c C-m")

(defun setup-clojure ()
  (subword-mode)
  (smartparens-mode)
  (flycheck-mode)
  (yas/minor-mode)
  (projectile-mode)
  (clj-refactor-mode)
  (rainbow-delimiters-mode)
  (eldoc-mode))

(setq cider-repl-use-clojure-font-lock t)

(setq cider-repl-result-prefix ";; => ")

(add-hook 'cider-mode-hook #'eldoc-mode)

(add-hook 'clojure-mode-hook 'setup-clojure)

(add-hook 'speedbar-load-hook (lambda ()
                                (push ".clj" speedbar-supported-extension-expressions)))
