(require-package 'transpose-frame)
(require-package 'evil)
(require-package 'magit)
(require-package 'flycheck)
(require-package 'smooth-scrolling)
(require-package 'company)
(require-package 'company-quickhelp)
(require-package 'markdown-mode+)

(global-auto-revert-mode 1)

(require 'transpose-frame)

;; UTF8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq auto-revert-verbose nil
      global-auto-revert-non-file-buffers t
      auto-save-default nil)

;; no backups
(setq make-backup-files nil)

;; column width is 80, not 72
(setq fill-column 80)

;; don't word wrap
(setq-default truncate-lines t)

;; more memory is fun
(setq gc-cons-threshold 20000000)

;; no minibuffer errors for flycheck, we use the window for that, unless it's not there
(setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)

(setq comment-auto-fill-only-comments t)

;; don't ask to create a new buffer
(setq ido-create-new-buffer 'always)

(setq confirm-nonexistent-file-or-buffer nil)

(setq kill-buffer-query-functions (remq 'process-kill-buffer-query-function
																				kill-buffer-query-functions))

;; electric indent 
(electric-indent-mode +1)
(electric-pair-mode)

(setq default-tab-width 2)

(fset 'yes-or-no-p 'y-or-n-p)

;; load settings directory
(mapc 'load (directory-files "~/.emacs.d/settings" t "^[A-Za-z-]*\\.el"))
