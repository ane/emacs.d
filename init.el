;;{{{
;; Bootstrap
(defconst emacs-start-time (current-time))

(require 'package)

(setq package-enable-at-startup nil)
;;
(add-to-list 'package-archives '("melpa"        . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("org"          . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("elpa"         . "https://elpa.gnu.org/packages/"))

;; https://github.com/purcell/emacs.d/blob/master/lisp/init-elpa.el#L64
;; (setq package-enable-at-startup nil)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-enable-imenu-support t)
;; install packages automatically if not already present on your
;; system to be global for all packages
(require 'use-package-ensure)

(setq refreshed nil)

(set-face-attribute 'default nil
                    :family "Cascadia Code"
                    :height 160
                    :weight 'normal
                    :width 'normal)
(set-face-attribute 'fixed-pitch nil :family "Cascadia Code")


(dolist (base-pkg '(s f dash dash-functional))
  (when (not (package-installed-p base-pkg))
    (unless refreshed
      (package-refresh-contents)
      (setq refreshed t))
    (package-install base-pkg))
  (require base-pkg))

(setq custom-file "~/.emacs.d/custom.el")

(when (file-exists-p custom-file)
  (load custom-file))

(when window-system
  (add-hook 'after-init-hook
            `(lambda ()
               (let ((elapsed (float-time (time-subtract (current-time)
                                                         emacs-start-time))))
                 (message "Loading %s...done (%.3fs) [after-init]"
                          ,load-file-name elapsed)))
            t))
;;}}}

;; Settings
;;{{{
(column-number-mode t)
(show-paren-mode 1)
(global-font-lock-mode t)
(winner-mode t)
(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


(setq calendar-week-start-day 1
      auto-save-default nil
      uniquify-buffer-name-style 'forward
      uniquify-ignore-buffers-re "^\\*"
      visible-bell t
      xterm-mouse-mode t
      user-mail-address "ane@iki.fi"
      user-full-name "Antoine Kalmbach"
      mac-option-modifier 'meta
      mac-command-modifier 'super
      set-mark-command-repeat-pop t)

(setq-default cursor 't)
(setq-default indent-tabs-mode nil)
(setq ns-right-alternate-modifier nil)
(setq ns-right-command-modifier 'control)
(setq ns-right-option-modifier 'hyper)

(defun setup-interface ()
  (interactive)
  (redraw-frame (selected-frame))
  (setq browse-url-browser-function 'browse-url-default-browser))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (setup-interface)))

(setup-interface)
(global-auto-revert-mode 1)
(global-hl-line-mode 1)
(display-time-mode 1)

;; UTF8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)
(setq-default default-buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

(setq system-time-locale "C")
(setq abbrev-file-name "~/Dropbox/abbrev_defs")
(setq save-abbrevs t)
(setq auto-revert-verbose nil
      global-auto-revert-non-file-buffers t
      auto-save-default nil)

;; column width is 80, not 72
(setq fill-column 80)
;; don't word wrap
(setq-default truncate-lines t)

;; line spacing
(setq-default line-spacing 0.25)

;; more memory is fun
(setq gc-cons-threshold 20000000)
(setq confirm-nonexistent-file-or-buffer nil)
(setq kill-buffer-query-functions (remq 'process-kill-buffer-query-function kill-buffer-query-functions))

;; electric indent 
(electric-indent-mode +1)
(electric-pair-mode +1)
(electric-layout-mode +1)

(setq default-tab-width 4)

(fset 'yes-or-no-p 'y-or-n-p)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program
      (pcase window-system
        ('ns "/Applications/Firefox.app/Contents/MacOS/firefox --new-tab")
        ('x "firefox")))

(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

(setq make-backup-files nil)

;; bindings
;;{{{
(global-unset-key (kbd "C-x f"))

(global-set-key (kbd "s-w") 'delete-window)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(global-set-key (kbd "C-S-g") 'magit)

(global-set-key (kbd "s-<left>")  'windmove-left) 
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<up>")    'windmove-up)
(global-set-key (kbd "s-<down>")  'windmove-down)

(global-set-key (kbd "M-SPC") 'company-complete)
(global-set-key (kbd "C-S-s") 'isearch-forward-symbol-at-point)

(global-set-key (kbd "C-o") 'vi-open-line-below)
(global-set-key (kbd "C-S-o") 'vi-open-line-above)

(global-set-key (kbd "s-k") #'kill-current-buffer)
(global-set-key (kbd "s-u") #'revert-buffer)
(global-set-key (kbd "s-m") (lambda ()
                              (interactive)
                              (switch-to-buffer-other-window "*Messages*")))

(global-set-key (kbd "s-i") 'imenu)

;; make CxCm act as M-x
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)

(global-set-key (kbd "C-M-j") 'delete-indentation)

(global-set-key (kbd "<f2>") #'switch-to-buffer)
(global-set-key (kbd "<f9>") #'rmail)
(global-set-key (kbd "S-<f9>") (lambda ()
                                 (interactive)
                                 (rmail-input "~/Dropbox/mail/out/sent.mbox")))
(global-set-key (kbd "<f6>") #'ane/open-emacs.d-init.el)
(global-set-key (kbd "<S-f6>") #'ane/open-emacs.d-modes.el)
(global-set-key (kbd "<f7>") #'ane/open-work-org)
(global-set-key (kbd "<S-f7>") #'ane/open-blog-org)
(global-set-key (kbd "<f5>") 'calendar)

(global-set-key (kbd "C-c C-d") #'insert-date-time)

(defun ane/open-emacs.d-init.el ()
  (interactive)
  (find-file (expand-file-name "~/.emacs.d/init.el")))

(defun ane/open-emacs.d-modes.el ()
  (interactive)
  (find-file (expand-file-name "~/.emacs.d/modes.el")))

(defun ane/open-work-org ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/org/work.org")))

(defun ane/open-blog-org ()
  (interactive) 
  (find-file (expand-file-name "~/Dropbox/org/blog.org")))

(savehist-mode)

;; yeah, I hate myself
(mapc 'global-unset-key [[up] [down] [left] [right]])

(global-tab-line-mode 1)

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(desktop-save-mode 1)
(setq desktop-save 'if-exists)
(setq desktop-path (list (expand-file-name "~/Dropbox/Private/Emacs/desktop/")))

;;
(add-to-list 'auth-sources 'macos-keychain-internet)
(add-to-list 'auth-sources 'macos-keychain-generic)

;;; Rmail

(require 'mairix)

(setq
 rmail-primary-inbox-list '("imaps://anhekalm%40gmail.com@imap.gmail.com")
 rmail-remote-password-required t
 rmail-preserve-inbox nil
 rmail-file-name "~/Dropbox/mail/inbox.mbox"
 mail-default-headers "FCC: ~/Dropbox/mail/out/sent.mbox"
 rmail-displayed-headers "^\\(?:Cc\\|Date\\|From\\|Subject\\|To\\):"
 rmail-output-file-alist '(("\\[IKI\\]" . "~/Dropbox/mail/old/iki.mbox")
                           (".*" . "~/Dropbox/mail/old/old.mbox"))
 rmail-delete-after-output t

 mairix-file-path "~/Dropbox/mail/"
 mairix-search-file "search.mbox")

 (setq sendmail-program "msmtp"
       message-send-mail-function 'message-send-mail-with-sendmail
       message-sendmail-extra-arguments '("--read-envelope-from")
       message-sendmail-envelope-from 'header
       message-sendmail-f-is-evil t
       message-interactive t
       message-kill-buffer-on-exit t
       message-signature "Antoine Kalmbach")

(setq mail-personal-alias-file "~/Dropbox/mail/aliases")

(add-hook 'message-setup-hook #'mail-abbrevs-setup)


;; Custom functions
;;{{{
(defun insdate-insert-current-date (&optional omit-day-of-week-p)
  "Insert today's date using the current locale.
  With a prefix argument, the date is inserted without the day of
  the week."
  (interactive "P*")
  (insert (calendar-date-string (calendar-current-date) nil
                                omit-day-of-week-p)))

(defun insert-date-time ()
  "Insert current date-time string in full ISO 8601 format.
Example: 2010-11-29T23:23:35-08:00"
  (interactive)
  (insert
   (concat
    (format-time-string "%Y-%m-%dT%T")
    ((lambda (x) (concat (substring x 0 3) ":" (substring x 3 5)))
     (format-time-string "%z")))))
;;}}}
;; packages

(add-hook 'text-mode-hook
          (lambda ()
            (auto-fill-mode)))

;; Additional loads
;;{{{
(load "~/.emacs.d/modes")
(load "~/.emacs.d/asciidoc")
;;}}}
;; config.el ends here
