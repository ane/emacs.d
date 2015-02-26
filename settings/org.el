(require 'org)

(setq org-agenda-files '("~/Dropbox/org")
      org-archive-location "~/Dropbox/org/archive.org::datetree/* Finished tasks"
      org-default-notes-file "~/Dropbox/org/work.org"
      org-agenda-window-setup 'current-window)

(defun my/org-config ()
  (make-variable-buffer-local 'after-save-hook)
  (org-indent-mode)
  (add-hook 'after-save-hook (lambda ()
                               (message "after save triggered!")
                               (org-agenda-maybe-redo)))
  (auto-revert-mode 1))

(add-hook 'org-mode-hook 'my/org-config)
