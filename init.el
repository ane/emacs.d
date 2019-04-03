;; Bootstrap
;;{{{
(defconst emacs-start-time (current-time))

(require 'package)

;;
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; for latest org-mode and org-plus-contrib
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

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

(setq-default indent-tabs-mode nil)
(setq ns-right-alternate-modifier nil)


(defun setup-interface ()
  (interactive)
  (let ((font-size (pcase window-system
                     ('x 15.0)
                     ('mac 16.0)
                     ('ns 16.0))))
    (set-default-font (font-spec :family "Fira Code" :weight 'medium :size font-size)))
  (global-hl-line-mode)
  (setq line-spacing 0.2)
  (redraw-frame (selected-frame))
  (setq browse-url-browser-function 'browse-url-default-browser))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (setup-interface)))

(setup-interface)
(global-auto-revert-mode 1)
(global-display-line-numbers-mode 1)

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

(defun my-compilation-finish-function (buf str) 
  (if (null (string-match ".*exited abnormally.*" str))
      ;;no errors, make the compilation window go away in a few seconds
      (progn
        (run-at-time
         "2 sec" nil 'delete-windows-on
         (get-buffer-create "*compilation*"))
        (message "No Compilation Errors!"))))

(setq compilation-finish-function 'my-compilation-finish-function)

(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

;; company settings

(setq tramp-default-method "ssh")

(setq make-backup-files nil)

;; bindings
;;{{{
(global-unset-key (kbd "C-x f"))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-h") 'windmove-left) 
(global-set-key (kbd "M-SPC") 'company-complete)
;; Bootstrap
;;{{{
(defconst emacs-start-time (current-time))

(require 'package)

;;
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; for latest org-mode and org-plus-contrib
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

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


(setq display-time-24hr-format t
      display-time-default-load-average nil
      info-use-header-line nil
      calendar-week-start-day 1
      auto-save-default nil
      initial-scratch-message nil
      isearch-lazy-highlight nil
      linum-format "%3d "
      show-trailing-whitespace t
      uniquify-buffer-name-style 'forward
      uniquify-ignore-buffers-re "^\\*"
      visible-bell t
      x-underline-at-descent-line t
      line-spacing 0.2
      xterm-mouse-mode t
      user-mail-address "ane@iki.fi"
      user-full-name "Antoine Kalmbach"
      mac-option-modifier 'meta
      mac-command-modifier 'super

      set-mark-command-repeat-pop t)

(setq-default indent-tabs-mode nil)
(setq ns-right-alternate-modifier nil)


(defun setup-interface ()
  (interactive)
  (let ((font-size (pcase window-system
                     ('x 15.0)
                     ('mac 16.0)
                     ('ns 16.0))))
    (set-default-font (font-spec :family "Fira Code" :weight 'medium :size font-size)))
  (global-hl-line-mode)
  (setq line-spacing 0.2)
  (redraw-frame (selected-frame))
  (setq browse-url-browser-function 'browse-url-default-browser))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (setup-interface)))

(setup-interface)
(global-auto-revert-mode 1)
(global-display-line-numbers-mode 1)

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

(defun my-compilation-finish-function (buf str) 
  (if (null (string-match ".*exited abnormally.*" str))
      ;;no errors, make the compilation window go away in a few seconds
      (progn
        (run-at-time
         "2 sec" nil 'delete-windows-on
         (get-buffer-create "*compilation*"))
        (message "No Compilation Errors!"))))

(setq compilation-finish-function 'my-compilation-finish-function)

(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

;; company settings

(setq tramp-default-method "ssh")

(setq make-backup-files nil)

;; bindings
;;{{{
(global-unset-key (kbd "C-x f"))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-h") 'windmove-left) 
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
(global-set-key (kbd "<f9>") #'evil-local-mode)
(global-set-key (kbd "<f6>") #'ane/open-emacs.d-init.el)
(global-set-key (kbd "<S-f6>") #'ane/open-emacs.d-modes.el)
(global-set-key (kbd "<f7>") #'ane/open-work-org)
(global-set-key (kbd "<S-f7>") #'ane/open-blog-org)
(global-set-key (kbd "<f10>") #'imenu-list-smart-toggle)

(global-set-key (kbd "C-c C-d") #'insert-date-time)

(global-set-key (kbd "s-<left>") #'previous-buffer)
(global-set-key (kbd "<wheel-left>") #'previous-buffer)
(global-set-key (kbd "s-<right>") #'next-buffer)
(global-set-key (kbd "<wheel-right>") #'next-buffer)
(global-set-key (kbd "s-<escape>") #'delete-other-windows)

(defun ane/open-emacs.d-init.el ()
  (interactive)
  (let ((projectile-switch-project-action 'ignore))
    (projectile-persp-switch-project "~/.emacs.d")
    (find-file (expand-file-name "~/.emacs.d/init.el"))))

(defun ane/open-emacs.d-modes.el ()
  (interactive)
  (let ((projectile-switch-project-action 'ignore))
    (projectile-persp-switch-project "~/.emacs.d")
    (find-file (expand-file-name "~/.emacs.d/modes.el"))))

(defun ane/open-work-org ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/org/work.org")))

(defun ane/open-blog-org ()
  (interactive) 
  (find-file (expand-file-name "~/Dropbox/org/blog.org")))



;; yeah, I hate myself
(mapc 'global-unset-key [[up] [down] [left] [right]])


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

;; align stuff
(defun my/align ()
  (interactive)
  (align-regexp
   (region-beginning)
   (region-end)
   "\\(\\s-*\\)\\(<-\\|=\\|\\$\\|::\\|->\\)"
   1
   align-default-spacing
   nil))

(add-hook 'text-mode-hook
          (lambda ()
            (auto-fill-mode)))

;; Additional loads
;;{{{
(load "~/.emacs.d/modes")
(load "~/.emacs.d/asciidoc")
;;}}}
;; config.el ends here
