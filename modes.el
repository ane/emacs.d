;; Built in crap

(add-hook 'inferior-lisp-mode-hook
          (lambda ()
            (paredit-mode)
            (rainbow-delimiters-mode)))

(use-package cider
  :config
  (use-package clojure-mode-extra-font-locking)
  (use-package clj-refactor)
  (cljr-add-keybindings-with-prefix "C-c C-m")
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook 'turn-on-visual-line-mode)
  (add-hook 'clojure-mode-hook (lambda ()
                                 (flycheck-mode)
                                 (yas/minor-mode)
                                 (paredit-mode)
                                 (clj-refactor-mode)
                                 (rainbow-delimiters-mode)
                                 (eldoc-mode))))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (setq exec-path-from-shell-variables '("PATH" "CLASSPATH" "JAVA_HOME"))
    (exec-path-from-shell-initialize)))

(use-package ace-window
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package rainbow-mode
  :diminish rainbow-mode
  :config
  (rainbow-mode))

(use-package aggressive-indent
  :diminish "")
(use-package rainbow-delimiters)

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
            (yas-minor-mode-on)
            (rainbow-delimiters-mode)
            (rainbow-mode)
            (company-mode)
            (paredit-mode)
            (set (make-local-variable 'company-backends) '(company-capf))))
;;}}}
(use-package company
  :diminish "C"
  :config
  (add-to-list 'company-backends 'company-files)
  (add-to-list 'company-backends 'company-capf)
  (setq company-idle-delay 0.2
        company-tooltip-align-annotations t
        company-minimum-prefix-length 2
        company-selection-wrap-around t)
  (add-hook 'css-mode-hook #'company-mode)
  (add-hook 'java-mode-hook #'company-mode))

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

(use-package magit)

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (use-package yasnippet-snippets)
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package modus-operandi-theme
  :config
  (load-theme 'modus-operandi t))

(use-package flycheck
  :diminish "!"
  :init
  (add-hook 'flycheck-mode-hook
            (lambda ()
              (define-key flycheck-mode-map (kbd "S-<next>") 'flycheck-next-error)
              (define-key flycheck-mode-map (kbd "S-<prior>") 'flycheck-previous-error))))

(use-package haskell-mode
  :ensure t
  :config
  (custom-set-variables
   '(haskell-process-suggest-hoogle-imports t)
   '(haskell-process-suggest-remove-import-lines t)
   '(haskell-process-auto-import-loaded-modules t)
   '(haskell-process-log t)
   '(haskell-process-type 'stack-ghci))
  (add-hook 'haskell-mode-hook
            (lambda ()
              (rainbow-delimiters-mode)
              (haskell-indentation-mode)
              (define-key haskell-mode-map (kbd "<f3>") #'my/align)))
  (use-package intero
    :ensure t
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
  (require 'org-tempo)
  (require 'ox-confluence)
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


  (make-variable-buffer-local 'after-save-hook)
  (auto-fill-mode)
  (abbrev-mode)
  (set-face-attribute 'org-level-1 nil :height 1.6)
  (set-face-attribute 'org-level-2 nil :height 1.2)
  (set-face-attribute 'org-level-3 nil :height 1.15)
  (set-face-attribute 'org-level-4 nil :height 1.1)
  (add-hook 'after-save-hook (lambda ()
                               (when (fboundp 'org-agenda-maybe-redo)
                                 (org-agenda-maybe-redo)))
            (auto-revert-mode 1)))

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

(use-package projectile
  :ensure t
  :diminish "Pro"
  :bind (("s-t" . projectile-toggle-between-implementation-and-test)
         ("s-T" . projectile-find-test-file)
         ("s-b" . projectile-switch-to-buffer)
         ("s-f" . projectile-find-file))
  :init
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy)
  (setq projectile-indexing-method 'hybrid)
  ;; (evil-leader/set-key "f" 'projectile-find-file)
  ;; (evil-leader/set-key "t" 'projectile-toggle-between-implementation-and-test)
  ;; (evil-leader/set-key "T" 'projectile-find-test-file)
  ;; (evil-leader/set-key "A" 'counsel-projectile-ag)
  ;; (evil-leader/set-key "b" 'projectile-switch-to-buffer)
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
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

;; (use-package perspective
;; :bind (("s-x" . persp-switch)
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
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "jsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))
  :custom-face
  (web-mode-current-column-highlight-face ((t (:background "LightSkyBlue1"))))
  (web-mode-current-element-highlight-face ((t (:inherit highlight))))
  )

;;}}}

;; Misc
;;{{{
(add-hook 'calendar-load-hook
          (lambda ()
            (calendar-set-date-style 'european)
            (setq calendar-week-start-day 1)))
;;}}}

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :init
  (setq ivy-use-virtual-buffers t)
  :config
  (ivy-mode 1)
  (setq ivy-height 15))

(use-package counsel
  :after ivy
  :diminish 'counsel-mode
  :config
  (counsel-mode 1)
  :bind (("s-a" . counsel-ag)))

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
  :bind (("s-h" . 'eglot-help-at-point))
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

(garbage-collect)
