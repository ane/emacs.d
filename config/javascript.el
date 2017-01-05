(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

(add-to-list 'company-backends 'company-tern)

(flycheck-add-mode 'javascript-eslint 'web-mode)
(setq js2-strict-missing-semi-warning nil)

(add-hook 'js2-mode-hook (lambda ()
                           (exec-path-from-shell-initialize)
                           (tern-mode t)
                           (rainbow-delimiters-mode)
                           (eldoc-mode)
                           (js2-refactor-mode)
                           (flycheck-mode)
                           (company-mode)))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

(add-hook 'js2-mode-hook #'setup-tide-mode)

(when (equal window-system 'w32)
  (setq tern-command `("node" ,(expand-file-name "~/AppData/Roaming/npm/node_modules/tern/bin/tern"))))

(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              (company-mode)
              (tern-mode t)
              (flycheck-mode))
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))
