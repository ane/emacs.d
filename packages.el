(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (push 'company-capf company-backends)
  (push 'company-files company-backends))

(use-package paredit
  :ensure t)

(use-package yasnippet
  :ensure t)

(use-package yasnippet
  :ensure t)

(use-package rainbow-delimiters-mode
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package helm
  :ensure t
  :init
  (setq helm-split-window-in-side-p t
        helm-ff-file-name-history-use-recentf t
        helm-M-x-fuzzy-match t
        helm-recentf-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-locate-fuzzy-match nil
        helm-imenu-fuzzy-match t
        helm-apropos-fuzzy-match t)
  (helm-mode))

;; Clojure
;;{{{  
(use-package clojure-mode
  :ensure t
  :config
  (defun setup-clojure ()
    (flycheck-mode)
    (yas/minor-mode)
    (projectile-mode)
    (paredit-mode)
    (clj-refactor-mode)
    (rainbow-delimiters-mode)
    (eldoc-mode))
  
  (add-hook 'clojure-mode-hook 'setup-clojure)
  
  (add-hook 'speedbar-load-hook
            (lambda ()
              (push ".clj" speedbar-supported-extension-expressions))))

(use-package cider
  :ensure t
  :config
  (setq cider-repl-use-clojure-font-lock t)
  (setq cider-repl-result-prefix ";; => ")
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-stacktrace-mode #'evil-emacs-state)
  (add-hook 'cider-repl-mode-hook
            (lambda ()
              (paredit-mode)
              (company-mode)
              (evil-local-mode 0))))

(use-package clj-refactor
  :ensure t)

(use-package clojure-mode-extra-font-locking
  :ensure t)
;;}}}


;; Emacs
;;{{{ 
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (flycheck-mode)
            (aggressive-indent-mode)
            (eldoc-mode)
            (folding-mode)
            (yas-minor-mode-on)
            (projectile-mode)
            (rainbow-delimiters-mode)
            (rainbow-mode)
            (company-mode)
            (paredit-mode)
            (set (make-local-variable 'company-backends) '(company-capf))))
;;}}}

;; Evil
;;{{{ 

(use-package evil
  :ensure t
  :config
  (setq evil-insert-state-cursor '("ForestGreen" bar)
        evil-normal-state-cursor '("magenta" box)
        evil-visual-state-cursor '("cyan" box)
        evil-default-cursor t
        evil-want-visual-char-semi-exclusive t
        evil-move-cursor-back nil
        evil-want-C-u-scroll t
        evil-ex-hl-update-delay 0.01)
  (add-hook 'evil-mode-hook (lambda ()
                              (define-key evil-normal-state-map ")" 'sentence-nav-evil-forward)
                              (define-key evil-normal-state-map "(" 'sentence-nav-evil-backward)
                              (define-key evil-normal-state-map "g)" 'sentence-nav-evil-forward-end)
                              (define-key evil-normal-state-map "g(" 'sentence-nav-evil-backward-end)
                              (define-key evil-outer-text-objects-map "s" 'sentence-nav-evil-outer-sentence)
                              (define-key evil-inner-text-objects-map "s" 'sentence-nav-evil-inner-sentence)))
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-set-initial-state 'eshell-mode 'emacs)
  (evil-set-initial-state 'alchemist-iex-mode 'emacs)
  (evil-set-initial-state 'comint-mode 'emacs)
  (evil-set-initial-state 'geiser-repl-mode 'emacs)
  (evil-set-initial-state 'slime-repl-mode 'emacs)
  (evil-set-initial-state 'cider-repl-mode 'emacs)
  (evil-set-initial-state 'ensime-inf-mode 'emacs)
  (evil-set-initial-state 'sbt-mode 'emacs)
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
  (evil-mode))

(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode)
  (setq-default evil-escape-key-sequence "fd")
  (setq-default evil-escape-delay 0.2)
  :bind
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "q") nil)
  (define-key evil-operator-state-map (kbd "q") nil)
  (setq-default evil-symbol-word-search t)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "f" 'helm-projectile-find-file)
  (evil-leader/set-key "F" 'helm-find-files)
  (evil-leader/set-key "p" 'helm-projectile-switch-project)
  (evil-leader/set-key "s" 'yas-insert-snippet)
  (evil-leader/set-key "t" 'projectile-toggle-between-implementation-and-test)
  (evil-leader/set-key "T" 'projectile-find-test-file)
  (evil-leader/set-key "a" 'helm-ag)
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
  (evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-last-sexp))

(use-package evil-escape
  :ensure t)

;;}}}

;; Haskell
;;{{{ 

(use-package haskell-mode
  :ensure t
  :init
  (let ((my-cabal-path (expand-file-name "~/.cabal/bin"))
        (local-bin-path (expand-file-name "~/.local/bin")))
    (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
    (setenv "PATH" (concat local-bin-path ":" (getenv "PATH")))
    (add-to-list 'exec-path my-cabal-path)
    (add-to-list 'exec-path local-bin-path))
  :config

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
    (electric-indent-local-mode -1)
    (flycheck-haskell-setup)
    (rainbow-delimiters-mode)
    (haskell-doc-mode)
    (interactive-haskell-mode)) 
  (add-hook 'haskell-mode-hook 'my/setup-haskell)
  (add-hook 'haskell-interactive-mode-hook 'company-mode))

;;}}}

;; Text
;;{{{ 

(use-package markdown-mode+
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
  :config
  (defun text-mode-settings ()
    (setq fill-column 100)
    (auto-fill-mode))
  (add-hook 'markdown-mode-hook #'text-mode-settings)
  (add-hook 'rst-mode-hook #'text-mode-settings)
  (setq markdown-command "kramdown"))

;;}}}

;; Org
;;{{{ 
(use-package org
  :ensure t
  :init
  (setq org-directory "~/Dropbox/org/"
        org-agenda-files '("work.org" "life.org")
        org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org"
        org-archive-location "~/Dropbox/org/archive.org::datetree/* Finished tasks"
        org-default-notes-file "~/Dropbox/org/work.org"
        org-mobile-directory "~/Dropbox/MobileOrg"
        org-agenda-window-setup 'current-window)
  :config
  (defun my/org-config ()
    (make-variable-buffer-local 'after-save-hook)
    (org-indent-mode)
    (auto-fill-mode)
    (add-hook 'after-save-hook (lambda ()
                                 (when (fboundp 'org-agenda-maybe-redo)
                                   (org-agenda-maybe-redo)))
              (auto-revert-mode 1)))
  (add-hook 'org-mode-hook 'my/org-config))

(use-package ox-reveal)

;;}}}

;; Projectile
;;{{{  
(use-package perspective
  :ensure t)

(use-package perspective
  :ensure t
  :init
  (persp-mode))

(use-package projectile
  :ensure t
  :init 
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
  (setq projectile-indexing-method 'alien)
  (helm-projectile-on))
;;}}}


;; Speedbar
;;{{{ 

(use-package sr-speedbar
  :ensure t
  :init
  (setq sr-speedbar-width 30)
  :config
  (add-hook 'speedbar-mode-hook
            (lambda()
              (speedbar-add-supported-extension "\\.rb")
              (speedbar-add-supported-extension "\\.ru")
              (speedbar-add-supported-extension "\\.erb")
              (speedbar-add-supported-extension "\\.rjs")
              (speedbar-add-supported-extension "\\.rhtml")
              (speedbar-add-supported-extension "\\.rake"))))
;;}}}

;; Scheme
;;{{{ 

(use-package geiser
  :ensure t
  :config
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
              (paredit-mode))))
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
(use-package web-mode
  :ensure t
  :config
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-enable-auto-closing t)
    (setq web-mode-enable-auto-opening t)
    (setq web-mode-enable-auto-expanding t)
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-enable-auto-quoting t)
    (company-mode))

  (add-hook 'web-mode-hook  'my-web-mode-hook)

  (add-to-list 'auto-mode-alist '("\\.xml" . web-mode)))
;;}}}

;; Magit
;;{{{ 
(use-package magit
  :ensure t)
;;}}}

