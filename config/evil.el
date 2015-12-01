(require 'evil)
(require 'evil-leader)
(use-package evil-smartparens)


(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-normal-state-map (kbd "q") nil)
(define-key evil-operator-state-map (kbd "q") nil)

(setq-default evil-symbol-word-search t)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "f" 'projectile-find-file)
(evil-leader/set-key "p" 'projectile-persp-switch-project)
(evil-leader/set-key "x" 'smex)
(evil-leader/set-key "s" 'yas-insert-snippet)
(evil-leader/set-key "t" 'projectile-toggle-between-implementation-and-test)
(evil-leader/set-key "T" 'projectile-find-test-file)
(evil-leader/set-key "g" 'magit-status)
(evil-leader/set-key "w" 'ace-window)
(evil-leader/set-key "b" 'projectile-switch-to-buffer)
(evil-leader/set-key "i" 'imenu)
(evil-leader/set-key "I" 'indent-region)
(evil-leader/set-key-for-mode 'js2-refactor-mode
  "r" (lambda () (discover-show-context-menu 'js2-refactor)))

(evil-leader/set-key-for-mode 'cider-mode "e" 'cider-eval-last-sexp)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-last-sexp)

(setq evil-insert-state-cursor '("HotPink1" (hbar . 4))
      evil-normal-state-cursor '("cyan1" box)
      evil-visual-state-cursor '("SeaGreen1" box)
      evil-default-cursor t
      evil-want-visual-char-semi-exclusive t
      evil-move-cursor-back nil
      evil-want-C-u-scroll t
      evil-ex-hl-update-delay 0.01)


(evil-mode)
(global-evil-leader-mode)
(global-evil-surround-mode)
(evil-exchange-install)
(evil-escape-mode)
(setq-default evil-escape-key-sequence "fd")
(setq-default evil-escape-delay 0.2)

(define-key evil-normal-state-map ")" 'sentence-nav-evil-forward)
(define-key evil-normal-state-map "(" 'sentence-nav-evil-backward)
(define-key evil-normal-state-map "g)" 'sentence-nav-evil-forward-end)
(define-key evil-normal-state-map "g(" 'sentence-nav-evil-backward-end)
(define-key evil-outer-text-objects-map "s" 'sentence-nav-evil-outer-sentence)
(define-key evil-inner-text-objects-map "s" 'sentence-nav-evil-inner-sentence)

(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'alchemist-iex-mode 'emacs)
(evil-set-initial-state 'comint-mode 'emacs)
(evil-set-initial-state 'geiser-repl-mode 'emacs)
(evil-set-initial-state 'slime-repl-mode 'emacs)
