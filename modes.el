(use-package company)

(push 'company-capf company-backends)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'projectile-mode)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook 'turn-on-visual-line-mode)

(require 'clojure-mode-extra-font-locking)
(cljr-add-keybindings-with-prefix "C-c C-m")

;; Clojure
;;{{{  
(defun setup-clojure ()
  (flycheck-mode)
  (yas/minor-mode)
  (projectile-mode)
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
(add-hook 'cider-repl-mode-hook (lambda ()
                                  (evil-local-mode 0)))

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

(use-package evil)
(use-package evil-leader)

(setq evil-insert-state-cursor '("ForestGreen" bar)
      evil-normal-state-cursor '("magenta" box)
      evil-visual-state-cursor '("cyan" box)
      evil-default-cursor t
      evil-want-visual-char-semi-exclusive t
      evil-move-cursor-back nil
      evil-want-C-u-scroll t
      evil-ex-hl-update-delay 0.01)


(setq-default evil-escape-key-sequence "fd")
(setq-default evil-escape-delay 0.2)

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
  (electric-indent-local-mode -1)
  (flycheck-haskell-setup)
  (rainbow-delimiters-mode)
  (haskell-doc-mode)
  (interactive-haskell-mode)) 


(add-hook 'haskell-mode-hook 'my/setup-haskell)
(add-hook 'haskell-interactive-mode-hook 'company-mode)

;;}}}

;; Common Lisp
;;{{{ 

(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))

(add-hook 'slime-mode-hook
          (lambda ()
            (company-mode)
	    (flycheck-mode)
            (rainbow-delimiters-mode)
            (paredit-mode)
            (yas/minor-mode)))

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
(use-package ox-reveal)

(setq org-directory "~/Dropbox/org/"
      org-agenda-files '("work.org" "life.org")
      org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org"
      org-archive-location "~/Dropbox/org/archive.org::datetree/* Finished tasks"
      org-default-notes-file "~/Dropbox/org/work.org"
      org-mobile-directory "~/Dropbox/MobileOrg"
      org-agenda-window-setup 'current-window)

(defun my/org-config ()
  (make-variable-buffer-local 'after-save-hook)
  (org-indent-mode)
  (auto-fill-mode)
  (add-hook 'after-save-hook (lambda ()
                               (when (fboundp 'org-agenda-maybe-redo)
                                 (org-agenda-maybe-redo)))
            (auto-revert-mode 1)))

(add-hook 'org-mode-hook 'my/org-config)
(setq org-journal-dir "~/Dropbox/org/journal/")

;;}}}

;; Projectile
;;{{{  
(persp-mode)
(use-package projectile)
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

(helm-projectile-on)
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
  (setq web-mode-enable-auto-quoting t)
  (company-mode))

(add-hook 'web-mode-hook  'my-web-mode-hook)

(add-to-list 'auto-mode-alist '("\\.xml" . web-mode))
;;}}}

;; Misc
;;{{{
(add-hook 'calendar-load-hook
          (lambda ()
            (calendar-set-date-style 'european)
            (setq calendar-week-start-day 1)))
;;}}}
