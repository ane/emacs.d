(require-package 'transpose-frame)
(require-package 'evil)
(require-package 'magit)
(require-package 'flycheck)
(require-package 'smooth-scrolling)
(require-package 'company)
(require-package 'company-quickhelp)
(require-package 'markdown-mode+)
(require-package 'gnus)
(require-package 'w3m)
(require-package 'wanderlust)
(require 'perse)

(autoload 'wl "wl" "Wanderlust" t)

(global-auto-revert-mode t)

(setq nnml-directory "~/mail")
(setq message-directory "~/mail")

(require 'transpose-frame)
(add-to-list 'load-path "~/.emacs.d/themes/solarized")


(setq gnus-summary-display-arrow t)
(setq gnus-summary-same-subject "")

(setq gnus-summary-line-format "%U%R%d %-5,5L %-20,20n %B%-80,80S\n"
      gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
      gnus-thread-sort-functions '(gnus-thread-sort-by-date)
      gnus-sum-thread-tree-false-root ""
      gnus-sum-thread-tree-indent " "
      gnus-sum-thread-tree-leaf-with-other "├► "
      gnus-sum-thread-tree-root ""
      gnus-sum-thread-tree-single-leaf "╰► "
      gnus-sum-thread-tree-vertical "│")

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
;; enable evil


;; electric indent 
(electric-indent-mode +1)
(electric-pair-mode)

(setq default-tab-width 2)

(fset 'yes-or-no-p 'y-or-n-p)

;; load settings directory
(mapc 'load (directory-files "~/.emacs.d/settings" t "^[A-Za-z-]*\\.el"))
