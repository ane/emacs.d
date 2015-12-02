(use-package org)

(setq org-agenda-files '("~/Dropbox/org")
      org-archive-location "~/Dropbox/archive.org::datetree/* Finished tasks"
      org-default-notes-file "~/Dropbox/org/work.org"
      org-agenda-window-setup 'current-window)

(defun my/org-config ()
  (make-variable-buffer-local 'after-save-hook)
  (org-indent-mode)
  (add-hook 'after-save-hook (lambda ()
                               (when (fboundp 'org-agenda-maybe-redo)
                                 (org-agenda-maybe-redo)))
  (auto-revert-mode 1)))

(setq jiralib-url "https://nfleet.atlassian.net"
      org-jira-default-jql "assignee = currentUser() and resolution = unresolved")

(add-hook 'org-mode-hook 'my/org-config)
