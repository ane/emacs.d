(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(defun text-mode-settings ()
  (setq fill-column 80)
  (auto-fill-mode))

(add-hook 'markdown-mode-hook #'text-mode-settings)
(add-hook 'rst-mode-hook #'text-mode-settings)

(setq markdown-command "marked")



