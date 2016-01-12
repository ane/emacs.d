(use-package org)

(setq org-directory "~/Dropbox/org/"
      org-agenda-files '("work.org" "life.org")
      org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org"
      org-archive-location "~/Dropbox/org/archive.org::datetree/* Finished tasks"
      org-default-notes-file "~/Dropbox/org/work.org"
      org-mobile-directory "~/Dropbox/MobileOrg"
      org-agenda-window-setup 'current-window)

(defun my/org-config ()
  (make-variable-buffer-local 'after-save-hook)
  (org-indent-mode)
  (org-bullets-mode)
  (auto-fill)
  (add-hook 'after-save-hook (lambda ()
                               (when (fboundp 'org-agenda-maybe-redo)
                                 (org-agenda-maybe-redo)))
  (auto-revert-mode 1)))

(add-hook 'org-mode-hook 'my/org-config)
