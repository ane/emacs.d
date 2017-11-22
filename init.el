;; Bootstrap
;;{{{
(defconst emacs-start-time (current-time))
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(setq refreshed nil)
(dolist (base-pkg '(use-package s f dash dash-functional))
  (when (not (package-installed-p base-pkg))
    (unless refreshed
      (package-refresh-contents)
      (setq refreshed t))
    (package-install base-pkg))
  (require base-pkg))

(setq custom-file "~/.emacs.d/custom.el")

(load "~/.emacs.d/autoinstall")

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
(use-package yasnippet)
(use-package company)
(use-package flycheck)

(column-number-mode t)
(show-paren-mode 1)
(global-font-lock-mode t)
(global-hl-line-mode -1)
(winner-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(rainbow-mode)

(setq display-time-24hr-format t
      display-time-default-load-average nil
      info-use-header-line nil
      cursor-type 'bar
      calendar-week-start-day 1
      auto-save-default nil
      company-tooltip-align-annotations t
      initial-scratch-message nil
      isearch-lazy-highlight nil
      linum-format "%3d "
      show-trailing-whitespace t
      uniquify-buffer-name-style 'forward
      uniquify-ignore-buffers-re "^\\*"
      visible-bell t
      x-underline-at-descent-line t
      xterm-mouse-mode t)


(setq-default indent-tabs-mode nil)
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
(setq speedbar-frame-parameters '((minibuffer)
                                  (width . 40)
                                  (border-width . 0)
                                  (menu-bar-lines . 0)
                                  (tool-bar-lines . 0)
                                  (unsplittable . t)
                                  (left-fringe . 0)))
(setq ns-right-alternate-modifier nil)

(setq neo-window-position 1)
(setq neo-theme 'arrow)
(setq neo-smart-open t)


(require 'spaceline-config)
(spaceline-spacemacs-theme)
(setq powerline-default-separator 'arrow)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)                              ; when a daemon, invoke theme startup 
(setq spaceline-workspace-numbers-unicode t)
(setq spaceline-window-numbers-unicode t)
(load-theme 'kaolin-dark t)

(defun setup-interface ()
  (interactive)
  (let ((font-size (pcase window-system
                     ('x 10.0)
                     ('ns 15.0))))
    (set-default-font (font-spec :family "Source Code Pro" :weight 'medium :size font-size)))
  (global-evil-leader-mode +1)
  (evil-escape-mode +1)
  (smooth-scrolling-mode)
  (global-hl-line-mode)
  (setq browse-url-browser-function 'browse-url-default-browser)
  (projectile-global-mode +1))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (setup-interface)))

(setup-interface)
(global-auto-revert-mode 1)

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
(setq comment-auto-fill-only-comments t)
(setq confirm-nonexistent-file-or-buffer nil)
(setq kill-buffer-query-functions (remq 'process-kill-buffer-query-function kill-buffer-query-functions))

;; electric indent 
(electric-indent-mode +1)
(electric-pair-mode +1)
(electric-layout-mode +1)

(setq default-tab-width 4)

(fset 'yes-or-no-p 'y-or-n-p)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(setq flycheck-check-syntax-automatically '(save))
(setq flycheck-check-syntax-automatically '(save)) 
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(defun my-compilation-finish-function (buf str) 
  (if (null (string-match ".*exited abnormally.*" str))
      ;;no errors, make the compilation window go away in a few seconds
      (progn
        (run-at-time
         "2 sec" nil 'delete-windows-on
         (get-buffer-create "*compilation*"))
        (message "No Compilation Errors!"))))

(setq compilation-finish-function 'my-compilation-finish-function)

;; enable projectile everywhere
(projectile-global-mode)

(when (eq 'ns (window-system))
  (exec-path-from-shell-initialize))

(global-set-key (kbd "M-o") 'yas-expand)
(setq eldoc-idle-delay 0.1)
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

;; company settings
(setq company-idle-delay 0.2
      company-minimum-prefix-length 2
      company-selection-wrap-around t)

(add-to-list 'company-backends 'company-files)
(setq tramp-default-method "ssh")

(setq make-backup-files nil)

;; set some sr-speedbar defaults
(setq sr-speedbar-width 30)

;; helm things
(setq helm-split-window-in-side-p t
      helm-ff-file-name-history-use-recentf t
      helm-M-x-fuzzy-match t
      helm-recentf-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-locate-fuzzy-match nil
      helm-imenu-fuzzy-match t
      helm-apropos-fuzzy-match t)

(helm-mode)
;;}}}

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
(global-set-key (kbd "C-S-SPC") 'company-complete)

(global-set-key (kbd "C-o") 'vi-open-line-below)
(global-set-key (kbd "C-S-o") 'vi-open-line-above)

(global-set-key (kbd "H-f") 'projectile-find-file)
(global-set-key (kbd "H-x") 'projectile-persp-switch-project)

(add-hook 'paredit-mode-hook (lambda ()
                               (define-key paredit-mode-map (kbd "M-l") 'paredit-backward-barf-sexp)
                               (define-key paredit-mode-map (kbd "M-;") 'paredit-backward-slurp-sexp)
                               (define-key paredit-mode-map (kbd "M-'") 'paredit-forward-slurp-sexp)
                               (define-key paredit-mode-map (kbd "M-\\") 'paredit-forward-barf-sexp)))

(add-hook 'flycheck-mode-hook
          (lambda ()
            (define-key flycheck-mode-map (kbd "S-<next>") 'flycheck-next-error)
            (define-key flycheck-mode-map (kbd "S-<prior>") 'flycheck-previous-error)))

;; make CxCm act as M-x
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

(global-set-key (kbd "C-M-j") 'delete-indentation)

(global-set-key (kbd "<f9>") #'evil-local-mode)
(global-set-key (kbd "<f7>") #'ane/open-work-org)

(defun ane/open-work-org ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/org/work.org")))

;; yeah, I hate myself
(mapc 'global-unset-key [[up] [down] [left] [right]])

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'hyper) ; Menu/App key

(global-set-key [f8] 'neotree-toggle)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-normal-state-map (kbd "q") nil)
(define-key evil-operator-state-map (kbd "q") nil)

(setq-default evil-symbol-word-search t)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "f" 'helm-projectile-find-file)
(evil-leader/set-key "F" 'helm-find-files)
(evil-leader/set-key "p" 'helm-projectile-switch-project)
(evil-leader/set-key "x" 'smex)
(evil-leader/set-key "s" 'yas-insert-snippet)
(evil-leader/set-key "t" 'projectile-toggle-between-implementation-and-test)
(evil-leader/set-key "T" 'projectile-find-test-file)
(evil-leader/set-key "a" 'helm-ag)
(evil-leader/set-key "A" 'helm-projectile-ag)
(evil-leader/set-key "g" 'magit-status)
(evil-leader/set-key "w" 'ace-window)
(evil-leader/set-key "b" 'helm-projectile-switch-to-buffer)
(evil-leader/set-key "B" 'list-buffers)
(evil-leader/set-key "i" 'helm-imenu)
(evil-leader/set-key "k" 'kill-buffer)
(evil-leader/set-key "o" 'helm-occur)
(evil-leader/set-key "h" 'previous-buffer)
(evil-leader/set-key "l" 'next-buffer)
(evil-leader/set-key "I" 'indent-region)

(evil-leader/set-key-for-mode 'cider-mode "e" 'cider-eval-last-sexp)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-last-sexp)
(windmove-default-keybindings)

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(global-set-key [escape] 'evil-exit-emacs-state)

;; neotree
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
;;}}}

;; Custom functions
;;{{{
(defun insdate-insert-current-date (&optional omit-day-of-week-p)
  "Insert today's date using the current locale.
  With a prefix argument, the date is inserted without the day of
  the week."
  (interactive "P*")
  (insert (calendar-date-string (calendar-current-date) nil
                                omit-day-of-week-p)))
;;}}}


;; Additional loads
;;{{{
(load "~/.emacs.d/modes")
;;}}}
;; config.el ends here
