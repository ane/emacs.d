(add-hook 'python-mode-hook
          (lambda ()
            (flycheck-mode)
            (elpy-enable)))
