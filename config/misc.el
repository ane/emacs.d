(add-hook 'graphviz-dot-mode-hook
          (lambda ()
            (define-key graphviz-dot-mode-map (kbd "C-c C-v") 'graphviz-dot-preview)))

(add-to-list 'auto-mode-alist '("\\.cql\\'" . sql-mode))
