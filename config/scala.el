(use-package ensime)
(add-hook 'scala-mode-hook #'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook #'eldoc-mode)
(add-hook 'scala-mode-hook #'yas-minor-mode)
(add-hook 'speedbar-load-hook (lambda ()
                                (push ".scala" speedbar-supported-extension-expressions)))

(add-hook 'sbt-mode-hook #'visual-line-mode)
(add-hook 'ensime-inf-mode #'visual-line-mode)



