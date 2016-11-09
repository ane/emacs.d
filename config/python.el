(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil
                  tab-width 4)
            (flycheck-mode)
            (elpy-enable)))
