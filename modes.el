(setq  use-package-always-ensure t)
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
  (when (eq 'ns (window-system))
    (exec-path-from-shell-initialize)))

(use-package ace-window
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package rainbow-mode
  :config
  (rainbow-mode))

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

(use-package aggressive-indent)
(use-package rainbow-delimiters)

;;}}}

(use-package eros
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
  :config
  (add-to-list 'company-backends 'company-files)
  (add-to-list 'company-backends 'company-capf)
  (setq company-idle-delay 0.2
        company-tooltip-align-annotations t
        company-minimum-prefix-length 2
        company-selection-wrap-around t))


(use-package paredit
  :init
  (add-hook 'paredit-mode-hook (lambda ()
                                 (define-key paredit-mode-map (kbd "M-l") 'paredit-backward-barf-sexp)
                                 (define-key paredit-mode-map (kbd "M-;") 'paredit-backward-slurp-sexp)
                                 (define-key paredit-mode-map (kbd "M-'") 'paredit-forward-slurp-sexp)
                                 (define-key paredit-mode-map (kbd "M-\\") 'paredit-forward-barf-sexp))))

(use-package magit)
;; Evil
;;{{{ 

(use-package evil
  :init
  (setq evil-insert-state-cursor '("ForestGreen" bar)
        evil-normal-state-cursor '("magenta" box)
        evil-visual-state-cursor '("cyan" box)
        evil-default-cursor t
        evil-want-visual-char-semi-exclusive t
        evil-move-cursor-back nil
        evil-want-C-u-scroll nil
        evil-ex-hl-update-delay 0.01)

  :config
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "q") nil)
  (define-key evil-operator-state-map (kbd "q") nil)
  (evil-mode 1))

(use-package evil-leader
  :after evil
  :hook (evil-mode . evil-leader-mode)
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "s" 'yas-insert-snippet)
  (evil-leader/set-key "a" 'counsel-ag)
  (evil-leader/set-key "g" 'magit-status)
  (evil-leader/set-key "w" 'ace-window)
  (evil-leader/set-key "B" 'list-buffers)
  (evil-leader/set-key "i" 'counsel-imenu)
  (evil-leader/set-key "k" 'kill-buffer)
  (evil-leader/set-key "l" 'next-buffer)
  (evil-leader/set-key "I" 'indent-region)
  (evil-leader/set-key "l" 'load-theme)
  (evil-leader/set-key "m" 'disable-theme)
  (global-evil-leader-mode 1))

(use-package evil-escape
  :after evil
  :init
  (setq-default evil-escape-key-sequence "fd")
  (setq-default evil-escape-delay 0.2)
  :config
  (evil-escape-mode 1)) 

(use-package evil-goggles
  :after evil
  :hook (evil-mode . evil-goggles-mode))

(use-package yasnippet)

(use-package kaolin-themes
  :config
  (load-theme 'kaolin-bubblegum t))

(use-package spaceline
  :init
  (setq powerline-default-separator 'wave) ;; butt... LOL
  (setq powerline-height 32)
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (setq spaceline-workspace-numbers-unicode t)
  (setq spaceline-window-numbers-unicode t)
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))

(dolist (mode '(clojure-mode-hook
                lisp-mode-hook
                emacs-lisp-mode-hook
                haskell-mode-hook
                erlang-mode-hook
                racket-mode-hook
                fundamental-mode-hook
                scheme-mode-hook
                python-mode-hook
                yaml-mode-hook
                ruby-mode-hook
                scala-mode-hook
                javascript-mode-hook
                typescript-mode-hook
                elm-mode-hook
                web-mode-hook
                scss-mode-hook
                plantuml-mode-hook
                css-mode-hook
                conf-unix-mode-hook
                ponylang-mode-hook
                rust-mode-hook
                text-mode-hook))
  (add-hook mode #'evil-local-mode))

;; Flycheck

(use-package flycheck
  :init
  (add-hook 'flycheck-mode-hook
            (lambda ()
              (define-key flycheck-mode-map (kbd "S-<next>") 'flycheck-next-error)
              (define-key flycheck-mode-map (kbd "S-<prior>") 'flycheck-previous-error))))

;;}}}

;; Haskell
;;{{{ 

;; (let ((my-cabal-path (expand-file-name "~/.cabal/bin"))
;;       (local-bin-path (expand-file-name "~/.local/bin")))
;;   (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
;;   (setenv "PATH" (concat local-bin-path ":" (getenv "PATH")))
;;   (add-to-list 'exec-path my-cabal-path)
;;   (add-to-list 'exec-path local-bin-path))

;; (evil-define-key 'insert haskell-interactive-mode-map (kbd "RET") 'haskell-interactive-mode-return)
;; (evil-define-key 'normal haskell-interactive-mode-map (kbd "RET") 'haskell-interactive-mode-return)

;; (add-hook 'speedbar-load-hook (lambda ()
;;                                 (push ".hs" speedbar-supported-extension-expressions)))


;; (add-to-list 'flycheck-disabled-checkers 'haskell-ghc)
;; (evil-leader/set-key-for-mode 'haskell-mode "h b" 'haskell-interactive-bring)
;; (evil-leader/set-key-for-mode 'haskell-mode "h t" 'haskell-process-do-type)
;; (evil-leader/set-key-for-mode 'haskell-mode "h i" 'haskell-process-do-info)
;; (evil-leader/set-key-for-mode 'haskell-mode "h c" 'haskell-process-cabal-build)
;; (evil-leader/set-key-for-mode 'haskell-mode "h k" 'haskell-interactive-mode-clear)
;; (evil-leader/set-key-for-mode 'haskell-mode "h l" 'haskell-process-load-or-reload)

;; (defun my/setup-haskell ()
;;   (company-mode)
;;   (flycheck-mode)
;;   (haskell-indentation-mode)
;;   (flycheck-haskell-setup)
;;   (rainbow-delimiters-mode)
;;   (haskell-doc-mode)
;;   (interactive-haskell-mode)
;;  ) 

;; (add-hook 'haskell-mode-hook 'my/setup-haskell)
;; (add-hook 'haskell-interactive-mode-hook 'company-mode)

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

;;}}}

;; Common Lisp
;;{{{ 

(use-package slime-company
  :ensure t)

(setq inferior-lisp-program "/usr/local/bin/sbcl")

(use-package slime
  :ensure t
  :config
  (let ((slime-helper (expand-file-name "~/quicklisp/slime-helper.el")))
    (when (file-exists-p slime-helper)
      (load slime-helper)))

  (setq slime-contribs '(slime-fancy slime-company))
  (add-hook 'slime-mode-hook
            (lambda ()
              (company-mode)
              (flycheck-mode)
              (rainbow-delimiters-mode)
              (paredit-mode)
              (yas/minor-mode)))
  (add-hook 'slime-repl-mode-hook
            (lambda ()
              (rainbow-delimiters-mode)
              (paredit-mode))))

(add-hook 'lisp-mode-hook
          (lambda ()
            (rainbow-delimiters-mode)
            (paredit-mode)))
;;}}}

;; Text
;;{{{ 

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
        org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org"
        org-archive-location "~/Dropbox/org/archive.org::datetree/* Finished tasks"
        org-default-notes-file "~/Dropbox/org/work.org"
        org-mobile-directory "~/Dropbox/MobileOrg"
        org-cycle-separator-lines 1
        org-log-done 'time
        org-confirm-babel-evaluate nil
        org-display-inline-images t
        org-publish-cache nil
        org-journal-dir "~/Dropbox/org/journal"
        org-agenda-window-setup 'current-window)
  :config
  ;; babel
  (define-key org-mode-map (kbd "<f3>")
    (lambda ()
      (interactive)
      (save-excursion
        (when (string-suffix-p ".org" (buffer-file-name))
          (set-buffer-modified-p t)
          (save-buffer))
        (org-publish-project "blog"))))
  (use-package htmlize)
  (require 'org-tempo)
  (require 'ox-confluence)
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

;;}}}

;; Projectile
;;{{{

(use-package counsel-projectile
  :ensure t)

(use-package projectile
  :ensure t
  :init
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
  (add-to-list 'projectile-globally-ignored-directories "project/target")
  (projectile-global-mode)
  (counsel-projectile-mode)
  (persp-mode)
  (setq projectile-completion-system 'ivy)
  (setq projectile-indexing-method 'alien)
  (evil-leader/set-key "f" 'projectile-find-file)
  (evil-leader/set-key "t" 'projectile-toggle-between-implementation-and-test)
  (evil-leader/set-key "T" 'projectile-find-test-file)
  (evil-leader/set-key "A" 'counsel-projectile-ag)
  (evil-leader/set-key "b" 'projectile-switch-to-buffer))



;;}}}

(use-package perspective
  :config
  (evil-leader/set-key "x" 'persp-switch)
  (evil-leader/set-key "X" 'persp-switch-last)
  )

(use-package persp-projectile
  :config
  (evil-leader/set-key "p" 'projectile-persp-switch-project))

;;}}}

;; Text
;;{{{ 
;;}}}

;; Web


(use-package web-mode
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-auto-pairing t)
  (electric-pair-mode -1)
  (setq web-mode-enable-auto-quoting t)

  (add-hook 'web-mode-hook #'company-mode)

  (add-to-list 'auto-mode-alist '("\\.xml" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html" . web-mode)))

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
  :init
  (setq ivy-use-virtual-buffers t)
  :config
  (ivy-mode 1))

(use-package counsel
  :after ivy
  :config
  (counsel-mode 1))

(use-package counsel-projectile
  :ensure t
  :after (counsel projectile))
;; Diminish
;;{{{

(use-package diminish
  :ensure t
  :init
  (diminish 'aggressive-indent-mode)
  (diminish 'auto-revert-mode)
  (diminish 'paredit-mode)
  (diminish 'evil-escape-mode)
  (diminish 'undo-tree-mode)
  (diminish 'rainbow-delimiters-mode)
  (diminish 'rainbow-mode)
  (diminish 'eldoc-mode)
  (diminish 'hasklig-mode)
  (diminish 'yas-minor-mode)
  (diminish 'counsel-mode)
  (diminish 'ivy-mode)
  (diminish 'refill-mode "RF")
  (diminish 'auto-fill-mode "AF")
  (diminish 'company-mode "C")
  (diminish 'intero-mode "I")
  (diminish 'flycheck-mode "!")
  (diminish 'projectile-mode "Pro"))

;;}}}

;; Idris

(use-package idris-mode
  :ensure t)

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

;; Erlang
;;{{{

(use-package erlang
  :ensure t
  :config
  (add-hook 'erlang-mode-hook #'company-erlang-init))

;;}}}

;; Elm
;;{{{
(use-package elm-mode
  :ensure t
  :config
  (add-hook 'elm-mode-hook  #'company-mode)
  (add-hook 'elm-mode-hook  #'flycheck-mode)
  (add-to-list 'company-backends 'company-elm)
  (use-package flycheck-elm
    :ensure t
    :config
    (add-hook 'flycheck-mode-hook 'flycheck-elm-setup))
  :init
  (progn 
    (custom-set-variables
     '(elm-interactive-command '("elm" "repl"))
     '(elm-reactor-command '("elm" "reactor"))
     '(elm-package-json "elm.json")
     '(elm-compile-arguments '("--output=elm.js" "--debug")))))
;;}}}


;; Sass

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
  (evil-leader/set-key-for-mode 'scala-mode "h" 'sbt-hydra))

(defun align-params ()
  (interactive)
  (align-regexp (region-beginning) (region-end) ": \\(\s*\\)" 1 0))

(defun bap ()
  (interactive)
  (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)\\(<-\\|=\\)")
  (align-regexp (region-beginning) (region-end) "\\(<-\\|=\\)\\(\\s-*\\)" 2))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :init
  (evil-leader/set-key-for-mode 'scala-mode "h" 'sbt-hydra)
  (evil-leader/set-key-for-mode 'scala-mode "i" 'lsp-ui-imenu)
  :config
  (add-hook 'sbt-mode-hook #'visual-line-mode)
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(use-package rust-mode
  :ensure t
  :hook (rust-mode . lsp))

;;;; LSP

(use-package lsp-mode
  :ensure t
  :init (setq lsp-prefer-flymake nil))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (define-key lsp-ui-mode-map (kbd "M-<") #'lsp-ui-peek-find-implementation)
  (define-key lsp-ui-mode-map (kbd "s-p") #'lsp-ui-peek-find-workspace-symbol)
  )

(use-package lsp-scala
  :ensure t
  :after scala-mode
  :demand t
  ;; Optional - enable lsp-scala automatically in scala files
  :hook (scala-mode . lsp))

(use-package company-lsp
  :ensure t
  :hook (lsp-ui-mode . company-mode)
  :config
  (push 'company-lsp company-backends))

;;;

(use-package neotree
  :ensure t
  :bind ("<f8>" . neotree-toggle)
  :config
  (setq neo-window-position 'right)
  (setq neo-theme 'arrow)
  (setq neo-smart-open t)
  )

(use-package company-go
  :ensure t
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode))))

(use-package smex
  :ensure t)

(use-package org-jira
  :ensure t
  :config
  (setq jiralib-url "https://extranet-sd.qvantel.com")
  (setq request-log-level 'debug))

(use-package ponylang-mode
  :ensure t
  :config
  (progn
    (add-hook
     'ponylang-mode-hook
     (lambda ()
       (set-variable 'indent-tabs-mode nil)
       (set-variable 'tab-width 2)))))

(use-package flycheck-pony
  :ensure t
  :config
  (setq create-lockfiles nil))


;;; js2/tsx

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :config
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "jsx" (file-name-extension buffer-file-name))
                (setup-tide-mode)))))

(use-package hasklig-mode
  :ensure t)

(use-package flycheck-yamllint
  :ensure t
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))))

(use-package ess
  :init (require 'ess-site))
