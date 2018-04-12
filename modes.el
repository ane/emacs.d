(use-package company)

(push 'company-capf company-backends)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook 'turn-on-visual-line-mode)

(require 'clojure-mode-extra-font-locking)
(cljr-add-keybindings-with-prefix "C-c C-m")

;; Clojure
;;{{{  
(defun setup-clojure ()
  (flycheck-mode)
  (yas/minor-mode)
  (paredit-mode)
  (clj-refactor-mode)
  (rainbow-delimiters-mode)
  (eldoc-mode))

(setq cider-repl-use-clojure-font-lock t)

(setq cider-repl-result-prefix ";; => ")

(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-stacktrace-mode #'evil-emacs-state)

(add-hook 'clojure-mode-hook 'setup-clojure)
(add-hook 'cider-repl-mode-hook #'paredit-mode)

(add-hook 'speedbar-load-hook (lambda ()
                                (push ".clj" speedbar-supported-extension-expressions)))

;;}}}

;; Emacs
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
        evil-want-C-u-scroll t
        evil-ex-hl-update-delay 0.01)

  (setq-default evil-escape-key-sequence "fd")
  (setq-default evil-escape-delay 0.2))

(use-package evil-leader
  :ensure t
  :hook (evil-mode)
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
  (evil-leader/set-key "L" 'disable-theme))

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
                elm-mode-hook
                web-mode-hook
                scss-mode-hook
                plantuml-mode-hook
                css-mode-hook
                text-mode-hook))
  (add-hook mode #'evil-local-mode))

;;}}}

;; Haskell
;;{{{ 

(let ((my-cabal-path (expand-file-name "~/.cabal/bin"))
      (local-bin-path (expand-file-name "~/.local/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (setenv "PATH" (concat local-bin-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path)
  (add-to-list 'exec-path local-bin-path))

(evil-define-key 'insert haskell-interactive-mode-map (kbd "RET") 'haskell-interactive-mode-return)
(evil-define-key 'normal haskell-interactive-mode-map (kbd "RET") 'haskell-interactive-mode-return)

(add-hook 'speedbar-load-hook (lambda ()
                                (push ".hs" speedbar-supported-extension-expressions)))

(custom-set-variables
 '(haskell-process-suggest-hoogle-imports t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-type 'stack-ghci))

(add-to-list 'flycheck-disabled-checkers 'haskell-ghc)
(evil-leader/set-key-for-mode 'haskell-mode "h b" 'haskell-interactive-bring)
(evil-leader/set-key-for-mode 'haskell-mode "h t" 'haskell-process-do-type)
(evil-leader/set-key-for-mode 'haskell-mode "h i" 'haskell-process-do-info)
(evil-leader/set-key-for-mode 'haskell-mode "h c" 'haskell-process-cabal-build)
(evil-leader/set-key-for-mode 'haskell-mode "h k" 'haskell-interactive-mode-clear)
(evil-leader/set-key-for-mode 'haskell-mode "h l" 'haskell-process-load-or-reload)

(defun my/setup-haskell ()
  (company-mode)
  (flycheck-mode)
  (haskell-indentation-mode)
  (flycheck-haskell-setup)
  (rainbow-delimiters-mode)
  (haskell-doc-mode)
  (interactive-haskell-mode)) 

(add-hook 'haskell-mode-hook 'my/setup-haskell)
(add-hook 'haskell-interactive-mode-hook 'company-mode)

;;}}}

;; Common Lisp
;;{{{ 

(let ((slime-helper (expand-file-name "~/quicklisp/slime-helper.el")))
  (when (file-exists-p slime-helper)
    (load slime-helper)))

(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy slime-company))

(add-hook 'slime-mode-hook
          (lambda ()
            (company-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)
            (paredit-mode)
            (yas/minor-mode)))

(add-hook 'lisp-mode-hook
          (lambda ()
            (rainbow-delimiters-mode)
            (paredit-mode)))
;;}}}

;; Text
;;{{{ 

(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(defun text-mode-settings ()
  (setq fill-column 100)
  (auto-fill-mode))

(add-hook 'markdown-mode-hook #'text-mode-settings)
(add-hook 'rst-mode-hook #'text-mode-settings)

(setq markdown-command "kramdown")

;;}}}

;; Org
;;{{{ 
(use-package org)

(setq org-directory "~/Dropbox/org/"
      org-agenda-files '("work.org" "life.org")
      org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org"
      org-archive-location "~/Dropbox/org/archive.org::datetree/* Finished tasks"
      org-default-notes-file "~/Dropbox/org/work.org"
      org-mobile-directory "~/Dropbox/MobileOrg"
      org-cycle-separator-lines 1
      org-log-done 'time
      org-agenda-window-setup 'current-window)

(defun my/org-config ()
  (interactive)
  (make-variable-buffer-local 'after-save-hook)
  (auto-fill-mode)
  (company-mode)
  (abbrev-mode)
  (set-face-attribute 'org-level-1 nil :height 1.6)
  (set-face-attribute 'org-level-2 nil :height 1.2)
  (set-face-attribute 'org-level-3 nil :height 1.15)
  (set-face-attribute 'org-level-4 nil :height 1.1)
  (doom-themes-org-config)
  (add-hook 'after-save-hook (lambda ()
                               (when (fboundp 'org-agenda-maybe-redo)
                                 (org-agenda-maybe-redo)))
            (auto-revert-mode 1))
  (org-indent-mode))
(add-hook 'org-mode-hook #'my/org-config)
(setq org-journal-dir "~/Dropbox/org/journal/")

;;}}}

;; Projectile
;;{{{  
(use-package projectile
  :ensure t
  :config
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories ".cache")
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
  (setq projectile-enable-caching t)
  (evil-leader/set-key "f" 'projectile-find-file)
  (evil-leader/set-key "p" 'projectile-persp-switch-project)
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

;; Racket
;;{{{
(defun setup-racket ()
  (paredit-mode)
  (evil-local-mode)
  (rainbow-delimiters-mode)
  (rainbow-mode)
  (company-mode))

(add-hook 'racket-mode-hook #'setup-racket)
(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))
;;}}}

;; Speedbar
;;{{{ 

(add-hook 'speedbar-mode-hook
          (lambda()
            (speedbar-add-supported-extension "\\.rb")
            (speedbar-add-supported-extension "\\.ru")
            (speedbar-add-supported-extension "\\.erb")
            (speedbar-add-supported-extension "\\.rjs")
            (speedbar-add-supported-extension "\\.rhtml")
            (speedbar-add-supported-extension "\\.rake")))
;;}}}

;; Scheme
;;{{{ 
(add-hook 'geiser-mode-hook
          (lambda ()
            (setq-local company-idle-delay 1)
            (rainbow-delimiters-mode)
            (yas-minor-mode-on)
            (paredit-mode)
            (eldoc-mode)
            (company-mode)))

(add-hook 'geiser-repl-mode-hook
          (lambda ()
            (rainbow-delimiters-mode)
            (company-mode)
            (paredit-mode)))
;;}}}

;; Text
;;{{{ 
(add-hook 'text-mode-hook #'setup-text-mode)

(defun setup-text-mode ()
  (setq fill-column 80)
  (auto-fill-mode))

;;}}}

;; Web
;;{{{ 
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-auto-pairing t)
  (electric-pair-mode -1)
  (setq web-mode-enable-auto-quoting t)
  (company-mode))

(add-hook 'web-mode-hook  'my-web-mode-hook)

(add-to-list 'auto-mode-alist '("\\.xml" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html" . web-mode))
;;}}}

;; Misc
;;{{{
(add-hook 'calendar-load-hook
          (lambda ()
            (calendar-set-date-style 'european)
            (setq calendar-week-start-day 1)))
;;}}}

(use-package ivy
  :ensure t)
(use-package counsel
  :ensure t)
(use-package counsel-projectile
  :ensure t)
;; Diminish
;;{{{

(use-package diminish
  :ensure t
  :init
  (diminish 'aggressive-indent-mode)
  (diminish 'helm-mode)
  (diminish 'auto-revert-mode)
  (diminish 'paredit-mode)
  (diminish 'evil-escape-mode)
  (diminish 'undo-tree-mode)
  (diminish 'rainbow-delimiters-mode)
  (diminish 'rainbow-mode)
  (diminish 'eldoc-mode)
  (diminish 'yas-minor-mode)
  (diminish 'counsel-mode)
  (diminish 'ivy-mode)
  (diminish 'flycheck-mode "!")
  (diminish 'projectile-mode "Proj"))

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
  :init (add-to-list 'company-backends 'company-elm))
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


;;; Scala & Ensime

(use-package ensime
  :ensure t)

(use-package scala-mode
  :init
  (evil-leader/set-key-for-mode 'scala-mode "h" 'sbt-hydra))

(use-package sbt-mode
  :init
  (evil-leader/set-key-for-mode 'scala-mode "h" 'sbt-hydra)
  (evil-leader/set-key-for-mode 'scala-mode "s t" 'ensime-type-at-point)
  (evil-leader/set-key-for-mode 'scala-mode "s r" 'ensime-typecheck-current-buffer)
  (evil-leader/set-key-for-mode 'scala-mode "r r" 'ensime-refactor-diff-rename)
  (evil-leader/set-key-for-mode 'scala-mode "r v" 'ensime-refactor-add-type-annotation)
  :config
  (add-hook 'sbt-mode-hook #'visual-line-mode))

(use-package neotree
  :ensure t
  :bind ("<f8>" . neotree-toggle)
  :config
  (setq neo-window-position 1)
  (setq neo-theme 'arrow)
  (setq neo-smart-open t)
  )

(use-package company-go
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode))))
