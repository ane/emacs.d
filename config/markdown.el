(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(add-hook 'markdown-mode-hook
          (lambda ()
            (setq fill-column 100)
            (auto-fill-mode)))

(setq markdown-command "marked")


