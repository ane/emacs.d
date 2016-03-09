(use-package ensime)
(add-hook 'scala-mode-hook #'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook #'eldoc-mode)
(add-hook 'scala-mode-hook #'yas-minor-mode)
(add-hook 'speedbar-load-hook (lambda ()
                                (push ".scala" speedbar-supported-extension-expressions)))

(add-hook 'scala-mode-hook #'scala-eldoc)

(defun scala-eldoc ()
  (setq-local eldoc-documentation-function
              (lambda ()
                (when (ensime-connected-p)
                  (ensime-print-type-at-point)))))
