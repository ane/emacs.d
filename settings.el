(require-package 'transpose-frame)
(require-package 'evil)
(require-package 'magit)
(global-auto-revert-mode t)

(setq auto-revert-verbose nil
      auto-save-default nil
			make-backup-files nil
      comment-auto-fill-only-comments t
      confirm-nonexistent-file-or-buffer nil
      custom-file "~/.emacs.d/custom.el"
      disabled-command-function nil
      global-auto-revert-non-file-buffers t
      kill-buffer-query-functions (remq 'process-kill-buffer-query-function
                                        kill-buffer-query-functions))
(evil-mode 1)
(electric-indent-mode +1)

(setq default-tab-width 2)

(c-set-offset 'case-label '+)

(fset 'yes-or-no-p 'y-or-n-p)

;; load settings directory
(mapc 'load (directory-files "~/.emacs.d/settings" t "^[A-Za-z-]*\\.el"))
