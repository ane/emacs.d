(require 'org)

(setq org-agenda-files (list "~/org/work.org")
      org-agenda-sticky t)
(add-hook 'org-mode-hook (lambda () (auto-revert-mode 1)))
(add-hook 'org-agenda-mode-hook (lambda () (auto-revert-mode 1)))
