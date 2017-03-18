(use-package company)

(push 'company-capf company-backends)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'projectile-mode)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook 'turn-on-visual-line-mode)

(require 'clojure-mode-extra-font-locking)
(cljr-add-keybindings-with-prefix "C-c C-m")

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

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(eval-after-load 'company
  '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook 'flycheck-mode)
(add-hook 'irony-mode-hook 'company-mode)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (flycheck-mode)
            (eldoc-mode)
            (yas-minor-mode-on)
            (projectile-mode)
            (rainbow-delimiters-mode)
            (rainbow-mode)
            (company-mode)
            (paredit-mode)
            (set (make-local-variable 'company-backends) '(company-capf))))
(add-hook 'elixir-mode-hook
          (lambda ()
            (company-mode)
            (alchemist-mode)))

(add-hook 'alchemist-iex-mode-hook
          (lambda ()
            (company-mode)))
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
;; GO
(add-hook 'go-mode-hook (lambda ()
                          (use-package go-projectile)
                          (go-eldoc-setup)
                          (flycheck-mode)
                          (subword-mode)
                          (yas/minor-mode)
                          (setq gofmt-command "goimports")
                          (setq gofmt-show-errors nil)
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (setq-local company-go-show-annotation t)
                          (setq-local intent-tabs-mode t)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(add-hook 'speedbar-load-hook (lambda ()
                                (push ".go" speedbar-supported-extension-expressions)))

(add-hook 'go-mode-hook #'rats-mode)
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
;(ido-mode t)
;(ido-vertical-mode t)
;(ido-everywhere t)
;(ido-ubiquitous t)
;(flx-ido-mode t)

;; (setq ido-auto-merge-work-directories-length 1
;;       ido-create-new-buffer 'always
;;       ido-enable-flex-matching t
;;       ido-use-faces nil
;;       ido-ignore-buffers `("\\` "
;;                            "^\\*Buffer List\\*"
;;                            "^\\*Compile-Log\\*"
;;                            "^\\*Helm"
;;                            "^\\*Help\\*"
;;                            "^\\*Ido"
;;                            "^\\*RE-Builder\\*"
;;                            "^\\*Shell Command Output\\*"
;;                            "^\\*Warnings\\*"
;;                            "^\\*XML Validation Header\\*"
;;                            "^\\*growl\\*"
;;                            "^\\*helm"
;;                            "^\\*magit"
;;                            "TAGS"
;;                            (lambda (name)
;;                              (save-excursion
;;                                (equal major-mode 'dired-mode))))
;;       ido-use-filename-at-point nil
;;       ido-use-virtual-buffers nil)

;; (add-to-list 'ido-ignore-files "\\.DS_Store")
;; (add-to-list 'ido-ignore-files "Icon$")


;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "C-x C-m") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

(add-to-list 'company-backends 'company-tern)

(flycheck-add-mode 'javascript-eslint 'web-mode)
(setq js2-strict-missing-semi-warning nil)

(add-hook 'js2-mode-hook (lambda ()
                           (exec-path-from-shell-initialize)
                           (tern-mode t)
                           (rainbow-delimiters-mode)
                           (eldoc-mode)
                           (js2-refactor-mode)
                           (flycheck-mode)
                           (company-mode)))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

(add-hook 'js2-mode-hook #'setup-tide-mode)
(add-hook 'before-save-hook 'tide-format-before-save)
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

(when (equal window-system 'w32)
  (setq tern-command `("node" ,(expand-file-name "~/AppData/Roaming/npm/node_modules/tern/bin/tern"))))

(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))
            (when (equal web-mode-content-type "jsx")
              (company-mode)
              (tern-mode t)
              (flycheck-mode))))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(add-hook 'typescript-mode-hook
          (lambda ()
            (setup-tide-mode)))
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))

(add-hook 'slime-mode-hook
          (lambda ()
            (company-mode)
	    (flycheck-mode)
            (rainbow-delimiters-mode)
            (paredit-mode)
            (yas/minor-mode)))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(defun text-mode-settings ()
  (setq fill-column 100)
  (auto-fill-mode))

(add-hook 'markdown-mode-hook #'text-mode-settings)
(add-hook 'rst-mode-hook #'text-mode-settings)

(setq markdown-command "kramdown")



(add-hook 'graphviz-dot-mode-hook
          (lambda ()
            (define-key graphviz-dot-mode-map (kbd "C-c C-v") 'graphviz-dot-preview)))

(add-to-list 'auto-mode-alist '("\\.cql\\'" . sql-mode))

(add-hook 'tuareg-mode-hook (lambda ()
                              (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
                              (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
                              (use-package merlin)
                              (use-package ocp-indent)
                              (setq merlin-command 'opam)
                              (setq merlin-error-after-save nil)
                              (flycheck-mode)
                              (flycheck-ocaml-setup)
                              (merlin-mode)
                              (add-to-list 'company-backends 'merlin-company-backend)
                              (company-mode)))



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

(setq monokai-use-variable-pitch nil)
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
(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil
                  tab-width 4)
            (flycheck-mode)
            (elpy-enable)))
(add-hook 'racket-mode-hook
          (lambda ()
            (local-unset-key ")")
            (local-unset-key "[")
            (local-unset-key "}")
            (local-unset-key "]")
            (projectile-mode)
            (yas/minor-mode)
            (company-mode)
            (eldoc-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)))
(add-hook 'ruby-mode-hook
          (lambda ()
            (use-package ruby-block)
            (company-mode)
            (add-to-list 'company-backends 'company-robe)
            (robe-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)
            (eldoc-mode)))

(add-hook 'speedbar-mode-hook
          (lambda()
            (speedbar-add-supported-extension "\\.rb")
            (speedbar-add-supported-extension "\\.ru")
            (speedbar-add-supported-extension "\\.erb")
            (speedbar-add-supported-extension "\\.rjs")
            (speedbar-add-supported-extension "\\.rhtml")
            (speedbar-add-supported-extension "\\.rake")))

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.haml\\'" . web-mode))
(add-hook 'speedbar-load-hook (lambda ()
                                (push ".rs" speedbar-supported-extension-expressions)))

(setq racer-cmd "~/.cargo/bin/racer")
(setq racer-rust-src-path "~/Downloads/rustc-1.7.0/src")

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(add-hook 'rust-mode-hook
          (lambda ()
            (setq company-tooltip-align-annotations t)
            (flycheck-mode)))

(use-package ensime)
(add-hook 'scala-mode-hook #'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook #'eldoc-mode)
(add-hook 'scala-mode-hook #'yas-minor-mode)
(add-hook 'speedbar-load-hook (lambda ()
                                (push ".scala" speedbar-supported-extension-expressions)))

(add-hook 'sbt-mode-hook #'visual-line-mode)
(add-hook 'ensime-inf-mode #'visual-line-mode)



(defun scheme-module-indent (state indent-point normal-indent) 0)

(add-hook 'geiser-mode-hook
          (lambda ()
            (setq-local company-idle-delay 1)
            (put 'module 'scheme-indent-function 'scheme-module-indent)
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
(add-hook 'text-mode-hook #'setup-text-mode)

(defun setup-text-mode ()
  (setq fill-column 80)
  (auto-fill-mode))
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
