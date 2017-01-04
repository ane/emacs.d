(add-hook 'text-mode-hook 'setup-text-mode)

(defun setup-text-mode ()
  (setq fill-column 100)
  (auto-fill-mode))
