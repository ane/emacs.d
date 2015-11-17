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

(setq kill-buffer-query-functions (remq 'process-kill-buffer-query-function kill-buffer-query-functions))

;; electric indent 
(electric-indent-mode +1)
(electric-pair-mode +1)

(setq default-tab-width 4)

(fset 'yes-or-no-p 'y-or-n-p)

;; load settings directory
(mapc 'load (mapcar 'file-name-sans-extension (directory-files "~/.emacs.d/config" t "^[A-Za-z-]*\\.el$")))

;; offer a function to byte compile the .emacs.d directory
(defun byte-compile-init-dir ()
  "Byte compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0))

(eval-after-load 'flycheck
  (lambda ()
    (flycheck-clojure-setup)
    (setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(setq flycheck-check-syntax-automatically '(save))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(defun my-compilation-finish-function (buf str)
  (unless (string-match ".*exited abnormally.*" str)
    (progn
      (run-at-time
       "2 sec"
       nil
       (lambda ()
         (progn 
           (interactive)
           (switch-to-buffer-other-window "*compilation*")
           (previous-buffer)
           (other-window -1))))
      (message "no compilation Errors!"))))

(setq compilation-finish-function 'my-compilation-finish-function)

;; enable projectile everywhere
(projectile-global-mode)

(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(setq yas/prompt-functions '(yas-ido-prompt))
(global-set-key (kbd "M-o") 'yas-expand)
(setq yas-fallback-behavior 'return-nil)
(yas-global-mode)

(setq eldoc-idle-delay 0.1)
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

;; company settings
(setq company-idle-delay 0.1
      company-minimum-prefix-length 2
      company-selection-wrap-around t)

(add-to-list 'company-backends 'company-files)

(setq tramp-default-method "ssh")

