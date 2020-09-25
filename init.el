;;{{{
;; Bootstrap

(require 'package)
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
(setq use-package-verbose t)
;; install packages automatically if not already present on your
;; system to be global for all packages

(require 'use-package)
(require 'use-package-ensure)

(setq-default line-spacing 0.2)

(set-face-attribute 'default nil
                    :family "Cascadia Code"
                    :height 160
                    :weight 'normal
                    :width 'normal)
(set-face-attribute 'fixed-pitch nil :family "Cascadia Code")


(setq custom-file "~/.emacs.d/custom.el")




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
      mac-option-modifier 'meta
      mac-command-modifier 'super
      mac-right-command-modifier 'hyper
      set-mark-command-repeat-pop t)

(setq-default cursor 't)
(setq-default indent-tabs-mode nil)
(setq ns-right-alternate-modifier nil)
(setq ns-right-command-modifier 'control)
(setq ns-right-option-modifier 'hyper)

(global-auto-revert-mode 1)
(global-hl-line-mode 1)

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

;; line spacing

;; more memory is fun
(setq gc-cons-threshold 20000000)
(setq confirm-nonexistent-file-or-buffer nil)
(setq kill-buffer-query-functions (remq 'process-kill-buffer-query-function kill-buffer-query-functions))

;; electric indent 
(electric-indent-mode 1)
(electric-pair-mode 1)
(electric-layout-mode 1)
(electric-quote-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program
      (pcase window-system
        ('ns "/Applications/Firefox.app/Contents/MacOS/firefox")
        ('mac "/Applications/Firefox.app/Contents/MacOS/firefox")
        ('x "firefox")))

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

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

(global-set-key (kbd "s-k") #'kill-current-buffer)
(global-set-key (kbd "s-u") #'revert-buffer)
(global-set-key (kbd "s-m") (lambda ()
                              (interactive)
                              (switch-to-buffer-other-window "*Messages*")))

(global-set-key (kbd "C-M-j") 'delete-indentation)

(global-set-key (kbd "<f2>") #'switch-to-buffer)
(global-set-key (kbd "<f6>") #'ane/open-emacs.d-init.el)
(global-set-key (kbd "<S-f6>") #'ane/open-emacs.d-modes.el)
(global-set-key (kbd "<f7>") #'ane/open-work-org)
(global-set-key (kbd "<S-f7>") #'ane/open-blog-org)

(global-set-key (kbd "C-c C-d") #'insert-date-time)

(global-set-key (kbd "s-`") #'previous-buffer)
(global-set-key (kbd "s-z") #'next-buffer)

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

;;

(use-package auth-source
  :ensure nil
  :config
  (add-to-list 'auth-sources 'macos-keychain-internet)
  (add-to-list 'auth-sources 'macos-keychain-generic))

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

(use-package imenu
  :ensure nil
  :bind (("s-i" . imenu)))

(use-package text-mode
  :ensure nil
  :hook (text-mode . auto-fill-mode))

;; (use-package inf-lisp
;;   :ensure nil
;;   :hook (inferior-lisp-mode . (paredit-mode rainbow-delimiters-mode)))


(use-package cider
  :defer t
  :config
  (use-package clojure-mode-extra-font-locking)
  (use-package clj-refactor)
  (cljr-add-keybindings-with-prefix "C-c C-m")
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook 'turn-on-visual-line-mode)
  (add-hook 'clojure-mode-hook (lambda ()
                                 (flycheck-mode)
                                 (yas-minor-mode)
                                 (paredit-mode)
                                 (clj-refactor-mode)
                                 (rainbow-delimiters-mode)
                                 (eldoc-mode))))

(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-check-startup-files nil)
  :if (memq window-system '(mac ns))
  :config
  (setq exec-path-from-shell-variables '("PATH" "CLASSPATH" "JAVA_HOME"))
  (exec-path-from-shell-initialize))

(use-package ace-window
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package rainbow-mode
  :diminish rainbow-mode
  :config
  (rainbow-mode))

(use-package aggressive-indent
  :diminish "")

(use-package rainbow-delimiters
  :hook ((lisp-mode scheme-mode) . rainbow-delimiters-mode))

;;}}}

(use-package eros
  :diminish eros-mode
  :hook (emacs-lisp-mode . eros-mode))

;; Emacs Lisp
;;{{{ 
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (flycheck-mode)
            (aggressive-indent-mode)
            (eldoc-mode)
            (rainbow-delimiters-mode)
            (rainbow-mode)
            (company-mode)
            (paredit-mode)))
;;}}}
(use-package company
  :diminish "Company"
  :config
  (add-to-list 'company-backends 'company-files)
  (add-to-list 'company-backends 'company-capf)
  (setq company-idle-delay 0.2
        company-tooltip-align-annotations t
        company-minimum-prefix-length 2
        company-selection-wrap-around t)
  (add-hook 'css-mode-hook #'company-mode)
  (add-hook 'java-mode-hook #'company-mode)
  (add-hook 'ielm-mode-hook #'company-mode))

;; (use-package company-box
;;   :after company
;;   :diminish ""
;;   :config
;;   (add-hook 'company-mode-hook #'company-box-mode))

(add-hook 'css-mode-hook
          (lambda ()
            (electric-pair-mode)))

(use-package paredit
  :diminish paredit-mode
  :init
  (add-hook 'paredit-mode-hook
            (lambda ()
              (define-key paredit-mode-map (kbd "M-l") 'paredit-backward-barf-sexp)
              (define-key paredit-mode-map (kbd "M-;") 'paredit-backward-slurp-sexp)
              (define-key paredit-mode-map (kbd "M-'") 'paredit-forward-slurp-sexp)
              (define-key paredit-mode-map (kbd "M-\\") 'paredit-forward-barf-sexp))))

(use-package magit
  :config
  (require 'magit-extras))

(use-package yasnippet
  :diminish yas-minor-mode
  :defer t
  :config
  (use-package yasnippet-snippets)
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package modus-operandi-theme
  :config
  (load-theme 'modus-operandi t))

(use-package flycheck
  :diminish ""
  :init
  (add-hook 'flycheck-mode-hook
            (lambda ()
              (define-key flycheck-mode-map (kbd "S-<next>") 'flycheck-next-error)
              (define-key flycheck-mode-map (kbd "S-<prior>") 'flycheck-previous-error))))

(use-package haskell-mode
  :ensure t
  :defer t
  :config
  (custom-set-variables
   '(haskell-process-suggest-hoogle-imports t)
   '(haskell-process-suggest-remove-import-lines t)
   '(haskell-process-auto-import-loaded-modules t)
   '(haskell-process-log t)
   '(haskell-process-type 'stack-ghci))
  (use-package intero
    :ensure t
    :defer t
    :config
    (progn
      (add-hook 'haskell-mode-hook 'intero-mode))))

(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(defun text-mode-settings ()
  (setq fill-column 80)
  (flyspell-mode)
  (auto-fill-mode))

(add-hook 'text-mode-hook #'text-mode-settings)

(setq markdown-command "kramdown")

;;}}}

;;{{{ 
(use-package org
  :ensure org-plus-contrib
  :defer t
  :init
  (setq org-startup-indented t
        org-startup-folded nil
        org-startup-align-all-tables t
        org-startup-with-inline-images t
        org-directory "~/Dropbox/org/"
        org-agenda-files '("work.org" "life.org")
        org-archive-location "~/Dropbox/archive.org::datetree/* Finished tasks"
        org-default-notes-file "~/Dropbox/org/work.org"
        org-cycle-separator-lines 1
        org-log-done 'time
        org-confirm-babel-evaluate nil
        org-display-inline-images t
        org-publish-cache nil
        org-html-htmlize-output-type 'css
        org-journal-dir "~/Dropbox/org/journal"
        org-agenda-window-setup 'current-window)
  :config
  ;; babel
  (use-package htmlize)
  (use-package org-tempo :ensure nil)
  (use-package ox-confluence :ensure nil)
  (setq org-directory (expand-file-name "~/Dropbox/org/"))
  (setq org-agenda-files (list "~/Dropbox/org/work.org"))
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((plantuml . t)
                                 (ditaa . t)
                                 (dot . t)
                                 (shell . t)
                                 (python . t)
                                 (R . t)))

  (setq org-plantuml-jar-path "/usr/local/lib/plantuml.jar"
        org-ditaa-jar-path "/usr/local/lib/ditaa.jar")

  (add-hook 'org-babel-after-execute-hook
            (lambda ()
              (when org-inline-image-overlays
                (org-redisplay-inline-images))))

  (add-hook 'org-mode-hook 'company-mode)

  (defun org-babel-edit-prep:java (babel-info)
    (setq-local buffer-file-name (->> babel-info caddr (alist-get :file-name)))
    (setq-local lsp-buffer-uri (->> babel-info caddr (alist-get :file-name) lsp--path-to-uri))
    (lsp)
    ;; other lsp-java specific stuff that you usually run with the major mode, company mode and so on.
    )

  (set-face-attribute 'org-level-1 nil :height 1.6)
  (set-face-attribute 'org-level-2 nil :height 1.2)
  (set-face-attribute 'org-level-3 nil :height 1.15)
  (set-face-attribute 'org-level-4 nil :height 1.1))

(use-package ox-asciidoc
  :ensure t
  :after org)

(use-package org-roam
  :ensure t
  :diminish ""
  :after org
  :config
  (setq org-roam-directory "~/Dropbox/org/roam/")
  (setq org-roam-tag-sources '(all-directories)))

(use-package org-journal
  :ensure t
  :after org
  :bind (("C-c C-j" . org-journal-new-entry))
  :config
  (setq org-journal-file-format "%Y%m%d.org"))

;;}}}

;; Projectile
;;{{{

(use-package counsel-projectile
  :ensure t
  :bind (("s-g" . counsel-projectile-ag))
  :config
  (counsel-projectile-mode))

(use-package project
  :pin elpa
  :after magit
  :bind (("s-p" . project-switch-project)
         ("s-f" . project-find-file)
         ("s-r" . project-query-replace-regexp)
         ("s-g" . magit-project-status)))

(use-package projectile
  :ensure t
  :diminish nil
  ;; :bind (
  ;; ("s-t" . projectile-toggle-between-implementation-and-test)
  ;; ("s-T" . projectile-find-test-file)
  ;; ("s-b" . projectile-switch-to-buffer)
  ;; ("s-f" . projectile-find-file)
  ;; )
  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-indexing-method 'hybrid)
  ;; (evil-leader/set-key "f" 'projectile-find-file)
  ;; (evil-leader/set-key "t" 'projectile-toggle-between-implementation-and-test)
  ;; (evil-leader/set-key "T" 'projectile-find-test-file)
  ;; (evil-leader/set-key "A" 'counsel-projectile-ag)
  ;; (evil-leader/set-key "b" 'projectile-switch-to-buffer)
  :config
  (add-to-list 'safe-local-variable-values
               '(projectile-tags-command . "make ctags"))
  (projectile-mode)
  ;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories ".cache")
  (add-to-list 'projectile-globally-ignored-directories ".metals")
  (add-to-list 'projectile-globally-ignored-directories ".bloop")
  (add-to-list 'projectile-globally-ignored-directories ".idea")
  (add-to-list 'projectile-globally-ignored-directories "node_modules")
  (add-to-list 'projectile-globally-ignored-directories ".cask")
  (add-to-list 'projectile-globally-ignored-directories ".cabal-sandbox")
  (add-to-list 'projectile-globally-ignored-directories ".python-environments")
  (add-to-list 'projectile-globally-ignored-directories "build")
  (add-to-list 'projectile-globally-ignored-directories "bin")
  (add-to-list 'projectile-globally-ignored-directories ".git")
  (add-to-list 'projectile-globally-ignored-directories "quelpa")
  (add-to-list 'projectile-globally-ignored-directories ".ensime_cache")
  (add-to-list 'projectile-globally-ignored-directories "target")
  (add-to-list 'projectile-globally-ignored-directories "project/project")
  (add-to-list 'projectile-globally-ignored-directories "project/target"))

(use-package project
  :pin elpa
  :config
  (mapc (lambda
          (dir) (add-to-list 'project-vc-ignores dir))
        '(".metals" ".idea" ".bloop" ".cache" "*eglot*" ".metadata" "/project/target" "/project/project" "target" "quelpa" "node-modules")))

;;}}}

;; ("s-z" . persp-switch-last)
;; ("s-r" . (lambda ()
;; (interactive)
;; (persp-remove-buffer (current-buffer)))))
;; :config
;; (persp-mode))
;; (evil-leader/set-key "x" 'persp-switch)
;; (evil-leader/set-key "z" 'persp-switch-last)
;; (evil-leader/set-key "r" (lambda ()
;; (interactive)
;; (persp-remove-buffer (current-buffer)))))

;; (use-package persp-projectile
;;   :bind (("s-c" . projectile-persp-switch-project)
;;          ("s-." . projectile-next-project-buffer)
;;          ("s-," . projectile-previous-project-buffer))
;;   :config
;;   (define-key projectile-mode-map [remap previous-buffer] #'projectile-previous-project-buffer)
;;   (define-key projectile-mode-map [remap next-buffer] #'projectile-next-project-buffer)
;;   ;; (evil-leader/set-key "p" 'projectile-persp-switch-project)
;;   )

;;}}}

;; Text
;;{{{ 
;;}}}

;; Web


(use-package web-mode
  :init
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-engine-detection t)
  (setq web-mode-enable-auto-quoting t)
  (setq web-mode-engines-alist '(("django" . "\\.html\\'")))

  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js[x]?\\'")
          ("tsx" . "\\.ts[x]?\\'")))

  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)

  (add-to-list 'auto-mode-alist '("\\.xml" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

  :config
  (add-hook 'web-mode-hook #'company-mode)
  (add-hook 'web-mode-hook (lambda () (electric-pair-mode -1)))
  
  :custom-face
  (web-mode-current-column-highlight-face ((t (:background "LightSkyBlue1"))))
  (web-mode-current-element-highlight-face ((t (:inherit highlight))))
  )

;;}}}

(use-package calendar
  :config
  (global-set-key (kbd "<f5>") 'calendar)
  (calendar-set-date-style 'european)
  (setq calendar-week-start-day 1))


(use-package ivy
  :ensure t
  :diminish ivy-mode
  :init
  (setq ivy-use-virtual-buffers t)
  :config
  (ivy-mode 1)
  (setq ivy-height 15))

(use-package ivy-avy
  :after ivy)


(use-package counsel
  :after ivy
  :diminish 'counsel-mode
  :config
  (counsel-mode 1)
  :bind (("s-a" . counsel-ag)
         ("M-x" . counsel-M-x)))

(use-package swiper
  :bind (("C-s" . swiper)))

;; SSH
;;{{{

(use-package ssh-config-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("/\\.ssh/config\\'"     . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/sshd?_config\\'"      . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode)))

;;}}}

;;{{{

(use-package scss-mode
  :ensure t
  :config
  (add-hook 'scss-mode-hook #''company-mode)
  :init
  (add-to-list 'auto-mode-alist '("\\.scss" . scss-mode)))

;;}}}

;; Yaml
;;{{{
(use-package yaml-mode
  :ensure t
  :config
  (add-hook 'yaml-mode-hook #'abbrev-mode)
  (add-hook 'yaml-mode-hook #'flycheck-mode))
;;}}}


;; PlantUML
;;{{{
(use-package plantuml-mode
  :ensure t
  :init
  (setq plantuml-jar-path "/usr/local/lib/plantuml.jar")
  (add-to-list 'auto-mode-alist '("\\.diag\\'" . plantuml-mode)))
;;}}}


;;; Scala 

(use-package scala-mode
  :init
  ;; (evil-leader/set-key-for-mode 'scala-mode "h" 'sbt-hydra)
  :config
  (add-hook 'scala-mode-hook (lambda () (electric-pair-mode +1))))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :init
  :config
  (add-hook 'sbt-mode-hook #'visual-line-mode)
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(use-package rust-mode
  :config
  (add-hook 'rust-mode-hook #'eglot-ensure))

;;;

(use-package lsp-mode
  :defer t
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'lsp-ivy-workspace-symbol))

(use-package lsp-java
  :after lsp-mode
  :hook (java-mode . lsp))

(use-package groovy-mode
  :config
  (defun my/groovy-mode-hook ()
    (setq c-basic-offset 2))
  (add-hook 'groovy-mode-hook #'my/groovy-mode-hook))

(use-package lsp-ivy
  :after '(lsp-mode ivy))

(use-package neotree
  :ensure t
  :bind (("<f8>" . neotree-toggle) ("s-n" . neotree-toggle))
  :config
  (setq neo-window-position 'left)
  (setq neo-theme 'arrow)
  (setq neo-window-width 40)
  (setq neo-smart-open t)
  )


(use-package flycheck-yamllint
  :ensure t
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))))

(use-package fennel-mode
  :init
  (add-to-list 'safe-local-variable-values '(inferior-lisp-program . "love ."))
  :config
  (add-hook 'fennel-mode-hook
            (lambda ()
              (interactive)
              (rainbow-delimiters-mode)
              (paredit-mode +1))))

(use-package graphviz-dot-mode)

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c @" . mc/mark-all-symbols-like-this)
         ("C-c M->" . mc/mark-next-like-this-symbol)
         ("C-c M-<" . mc/mark-previous-like-this-symbol)
         ("C-c C->" . mc/mark-next-like-this-word)
         ("C-c C-<" . mc/mark-previous-like-this-word)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package treemacs
  :bind ("C-c C-t" . treemacs)
  :config
  (setq treemacs-no-png-images t))

(use-package treemacs-projectile
  :after treemacs)

(use-package eglot
  :pin melpa
  :config
  ;; (optional) Automatically start metals for Scala files.
  :hook
  (scala-mode . eglot-ensure)
  (scala-mode . company-mode)
  (go-mode    . eglot-ensure)
  (go-mode    . company-mode)
  (java-mode  . company-mode))

(use-package flymake
  :pin elpa)

(use-package markdown-mode)

(use-package diminish)


(diminish 'eldoc-mode)
(diminish 'subword-mode)
(diminish 'flymake-mode "FM")
(diminish 'auto-fill-mode "Fil")
(diminish 'abbrev-mode "Ab")

(use-package restclient)

(use-package eldoc-box
  :diminish eldoc-box-hover-at-point-mode
  :config
  (add-hook 'eldoc-mode-hook #'eldoc-box-hover-at-point-mode))

(use-package smart-mode-line
  :config
  (sml/setup))

(use-package smex)

;; (use-package mu4e
;;   :ensure nil
;;   :load-path
;;   "/usr/local/Cellar/mu/1.4.13/share/emacs/site-lisp/mu/mu4e/"
;;   :config
;;   (setq mu4e-sent-folder "/[Gmail].Sent Mail"
;;         mu4e-drafts-folder "/[Gmail].Drafts"
;;         mu4e-trash-folder "/[Gmail].Trash"

;;         mu4e-get-mail-command "offlineimap"

;;         mu4e-update-interval 300
;;         mu4e-index-update-in-background t
;;         mu4e-maildir-shortcuts '(("/INBOX" . ?i)
;;                                  ("/[Gmail].Sent Mail" . ?s))
;;         ))

(use-package sly
  :config
  (setq inferior-lisp-program "/usr/local/bin/sbcl")
  (add-hook 'lisp-mode-hook #'company-mode)
  (add-hook 'sly-mrepl-mode-hook #'company-mode))

;; (use-package desktop
;;   :config
;;   (desktop-save-mode 1)
;;   (setq desktop-save 'if-exists)
;;   (setq desktop-path (list (expand-file-name "~/Dropbox/Private/Emacs/desktop/"))))

(use-package mairix
  :config
  (setq mairix-file-path "~/Dropbox/mail/"
        mairix-search-file "search.mbox"))

(use-package perspective
  :demand t
  :init
  (setq persp-state-default-file "~/Dropbox/emacs/perspective")
  :bind (("s-x" . persp-switch)
         ("H-," . persp-prev)
         ("H-." . persp-next)
         ("s-c" . persp-kill)
         ("s-q" . persp-switch-quick)
         ("s-b" . persp-counsel-switch-buffer)
         ("s-B" . persp-ivy-switch-buffer))
  :config
  (persp-mode)
  (add-hook 'kill-emacs-hook #'persp-state-save))

;; (use-package tab-bar
;;   :config
;;   (setq tab-bar-tab-hints t)
;;   (setq tab-bar-select-tab-modifiers '(super))

;;   (global-set-key (kbd "M-s-<right>") #'tab-bar-switch-to-next-tab)
;;   (global-set-key (kbd "M-s-<left>") #'tab-bar-switch-to-prev-tab))

(use-package tab-line
  :ensure nil
  :config
  (global-tab-line-mode 1)
  (setq tab-line-tabs-function 'tab-line-tabs-window-buffers)
  (global-set-key (kbd "C-s-<right>") #'tab-line-switch-to-next-tab)
  (global-set-key (kbd "C-s-<left>") #'tab-line-switch-to-prev-tab)  )

(use-package time
  :ensure nil
  :config
  (setq display-time-mail-directory "~/Dropbox/mail/imap/INBOX/new")
  (setq display-time-24hr-format t)

  (display-time-mode 1))

(use-package smtpmail
  :ensure nil
  :config
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq smtpmail-smtp-server "smtp.iki.fi")
  (setq smtpmail-smtp-user "ane")
  (setq smtpmail-smtp-service 587)
  (setq smtpmail-stream-type 'starttls)
  )

(use-package message
  :ensure nil
  :after smtpmail
  :config
  (setq
   ;; sendmail-program "msmtp"
   message-default-headers "FCC: ~/Dropbox/mail/out/sent.mbox"
   ;; message-send-mail-function 'message-send-mail-with-sendmail
   ;; message-sendmail-extra-arguments '("--read-envelope-from")
   ;; message-sendmail-envelope-from 'header
   ;; message-sendmail-f-is-evil t

   user-mail-address "ane@iki.fi"
   user-full-name "Antoine Kalmbach"

   mail-user-agent 'message-user-agent
   message-interactive t
   message-wide-reply-confirm-recipients t
   message-fcc-handler-function 'rmail-output
   message-kill-buffer-on-exit t
   mail-signature "Antoine Kalmbach\n\n"
   message-signature mail-signature
   mail-personal-alias-file "~/Dropbox/mail/aliases")
  
  (add-hook 'message-setup-hook #'mail-abbrevs-setup))

(use-package rmail
  :defer t
  :config
  (global-set-key (kbd "<f9>") #'rmail)
  (global-set-key (kbd "S-<f9>") (lambda ()
                                   (interactive)
                                   (rmail-input "~/Dropbox/mail/out/sent.mbox")))
  
  (setq rmail-primary-inbox-list '("maildir:///Users/akalmbach/Dropbox/mail/imap/INBOX")
        rmail-remote-password-required t
        rmail-preserve-inbox nil
        rmail-file-name "~/Dropbox/mail/inbox.mbox"
        rmail-displayed-headers "^\\(?:Cc\\|Date\\|From\\|Subject\\|To\\|List-Id\\):"
        rmail-output-file-alist '(("\\[IKI\\]" . "~/Dropbox/mail/old/iki.mbox")
                                  (".*"        . "~/Dropbox/mail/old/old.mbox"))
        rmail-delete-after-output t
        rmail-default-file "~/Dropbox/mail/old/old.mbox"
        rmail-automatic-folder-directives '(("me.mbox" "from" "Antoine")
                                            ("nordea.mbox" "from" "nordea")
                                            ("oks.mbox" "from" "Olutkulttuuriseura")
                                            ("vihrea.mbox" "from" "Vihreät")
                                            ("iki.mbox" "from" "\\[IKI\\]"))))

(use-package hydra
  :config
  (defhydra rmail-menu (:color pink :hint nil)
    "
^General^          ^Output files^     ^Auto-Folders^     ^List Folders^   
^^^^^^^^^---------------------------------------------------------------------------
_i_: inbox         _d_: default       _f_: finances      e: emacs-devel
_s_: sent mail     _k_: iki.mbox      _o_: OKS           n: fennel
_x_: search        ^ ^                _k_: IKI           g: guile

"
    ("i" rmail)
    ("s" (rmail-input "~/Dropbox/mail/out/sent.mbox"))
    ("d" (rmail-input rmail-default-file))
    ("f" (rmail-input "~/Dropbox/mail/old/nordea.mbox"))
    ("k" (rmail-input "~/Dropbox/mail/old/iki.mbox"))
    ("o" (rmail-input "~/Dropbox/mail/old/oks.mbox"))
    ("x" mairix-search)
    ("q" nil "quit")
    ))

(use-package rmail-hydra
  :ensure nil
  :load-path "~/code/rmail-hydra")

(use-package gnus
  :config
  (setq gnus-select-method '(nnnil ""))  
  (setq gnus-secondary-select-methods '((nntp "gmane" (nntp-address "news.gmane.io"))))
  (setq gnus-gcc-mark-as-read t)
  (setq gnus-agent t)
  (setq gnus-check-new-newsgroups 'ask-server)
  (setq gnus-read-active-file 'some)
  ;; dribble
  (setq gnus-use-dribble-file t)
  (setq gnus-always-read-dribble-file t))

(use-package gnus-group
  :after gnus
  :ensure nil
  :config
  (setq gnus-level-subscribed 6)
  (setq gnus-level-unsubscribed 7)
  (setq gnus-level-zombie 8)
  (setq gnus-activate-level 2)
  (setq gnus-list-groups-with-ticked-articles nil)
  (setq gnus-group-sort-function
        '((gnus-group-sort-by-unread)
          (gnus-group-sort-by-alphabet)
          (gnus-group-sort-by-rank)))
  (setq gnus-group-line-format "%M%p%P%5y:%B%(%g%)\n")
  (setq gnus-group-mode-line-format "%%b")
  :hook ((gnus-group-mode-hook . hl-line-mode)
         (gnus-select-group-hook . gnus-group-set-timestamp))
  :bind (:map gnus-group-mode-map
              ("M-n" . gnus-topic-goto-next-topic)
              ("M-p" . gnus-topic-goto-previous-topic)))

(use-package gnus-topic
  :after (gnus gnus-group)
  :ensure nil
  :config
  (setq gnus-topic-display-empty-topics nil)
  (add-hook 'gnus-group-mode-hook #'gnus-topic-mode))

(use-package gnus-async
  :after gnus
  :ensure nil
  :config
  (setq gnus-asynchronous t)
  (setq gnus-use-article-prefetch 15))

(use-package gnus-sum
  :after gnus
  :ensure nil
  :config
  (setq gnus-auto-select-first nil)
  (setq gnus-summary-ignore-duplicates t)
  (setq gnus-suppress-duplicates t)
  (setq gnus-save-duplicate-list t)
  (setq gnus-summary-goto-unread nil)
  (setq gnus-summary-make-false-root 'adopt)
  (setq gnus-summary-thread-gathering-function
        'gnus-gather-threads-by-subject)
  (setq gnus-summary-gather-subject-limit 'fuzzy)
  (setq gnus-thread-sort-functions
        '((not gnus-thread-sort-by-date)
          (not gnus-thread-sort-by-number)))
  (setq gnus-subthread-sort-functions
        'gnus-thread-sort-by-date)
  (setq gnus-thread-hide-subtree nil)
  (setq gnus-thread-ignore-subject nil)
  (setq gnus-user-date-format-alist
        '(((gnus-seconds-today) . "Today at %R")
          ((+ (* 60 60 24) (gnus-seconds-today)) . "Yesterday, %R")
          (t . "%Y-%m-%d %R")))
  (setq gnus-face-1 'gnus-header-content)
  (setq gnus-face-2 'gnus-header-from)
  (setq gnus-face-3 'gnus-header-subject)
  (setq gnus-summary-line-format "%U%R  %1{%-16,16&user-date;%}  %2{%-25,25f%}  %3{%B%S%}\n")
  (setq gnus-summary-mode-line-format "%p")
  ;; (setq gnus-sum-thread-tree-false-root ""
  ;;       gnus-sum-thread-tree-indent " "
  ;;       gnus-sum-thread-tree-leaf-with-other "├► "
  ;;       gnus-sum-thread-tree-root ""
  ;;       gnus-sum-thread-tree-single-leaf "╰► "
  ;;       gnus-sum-thread-tree-vertical "│")
  (setq gnus-sum-thread-tree-false-root "─┬> ")
  (setq gnus-sum-thread-tree-indent " ")
  (setq gnus-sum-thread-tree-single-indent "")
  (setq gnus-sum-thread-tree-leaf-with-other "├─> ")
  (setq gnus-sum-thread-tree-root "")
  (setq gnus-sum-thread-tree-single-leaf "└─> ")
  (setq gnus-sum-thread-tree-vertical "│")
  )

(use-package geiser
  :hook (geiser-repl-mode . paredit-mode))

(use-package ggtags)

(use-package cc-mode
  :ensure nil
  :init
  (defun cxx-mode-hook ()
    (flymake-mode)
    (company-mode)
    (yas-minor-mode)
    (eldoc-mode)
    (ggtags-mode)
    (semantic-mode)
    (semantic-idle-summary-mode 1)
    (global-semantic-mru-bookmark-mode 1)
    (semantic-add-system-include "/usr/local/Cellar/guile/3.0.4/include/guile/3.0"))
  :config
  (add-hook 'c-mode-hook #'cxx-mode-hook)
  (add-hook 'c++-mode-hook #'cxx-mode-hook)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode)
  )

(garbage-collect)
;;}}}
