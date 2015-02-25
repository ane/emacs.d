(require 'org)

(setq org-agenda-files (list "~/org/work.org")
      org-agenda-window-setup 'current-window)

(defun my/org-config ()
  (make-variable-buffer-local 'after-save-hook)
  (add-hook 'after-save-hook (lambda ()
                               (message "after save triggered!")
                               (org-agenda-maybe-redo)))
  (auto-revert-mode 1))

(add-hook 'org-mode-hook 'my/org-config)
