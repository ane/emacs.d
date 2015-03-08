(global-auto-revert-mode 1)

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
(mapc 'load (mapcar 'file-name-sans-extension (directory-files "~/.emacs.d/settings" t "^[A-Za-z-]*\\.el$")))

;; offer a function to byte compile the .emacs.d directory
(defun byte-compile-init-dir ()
  "Byte compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0))

(eval-after-load 'flycheck
  '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))
