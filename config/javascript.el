(use-package flycheck)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

(add-to-list 'company-backends 'company-tern)

(flycheck-add-mode 'javascript-eslint 'web-mode)

(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode t)
                           (eldoc-mode)
                           (js2-refactor-mode)
                           (flycheck-mode)
                           (company-mode)))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(when (equal window-system 'w32)
  (setq tern-command `("node" ,(expand-file-name "~/AppData/Roaming/npm/node_modules/tern/bin/tern"))))

(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              (company-mode)
              (tern-mode t)
              (flycheck-mode))))
