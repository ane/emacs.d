
(require 'evil)
(require 'evil-leader)
(use-package evil-smartparens)

(setq-default evil-escape-key-sequence "jk")


(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-normal-state-map (kbd "q") nil)
(define-key evil-operator-state-map (kbd "q") nil)
(define-key evil-insert-state-map (kbd "<escape>") nil)

(add-hook 'smartparens-strict-mode-hook #'evil-smartparens-mode)
(setq-default evil-symbol-word-search t)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "f" 'projectile-find-file)
(evil-leader/set-key "p" 'projectile-persp-switch-project)
(evil-leader/set-key "s" 'yas-insert-snippet)
(evil-leader/set-key "t" 'projectile-toggle-between-implementation-and-test)
(evil-leader/set-key "t" 'projectile-find-test-file)
(evil-leader/set-key "g" 'magit-status)
(evil-leader/set-key "w" 'ace-window)
(evil-leader/set-key "b" 'projectile-switch-to-buffer)
(evil-leader/set-key "i" 'imenu)
(evil-leader/set-key "I" 'indent-region)

(evil-leader/set-key-for-mode 'cider-mode "e" 'cider-eval-last-sexp)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-last-sexp)

(setq evil-insert-state-cursor '("dodger blue" bar)
      evil-normal-state-cursor '("white" box)
      evil-visual-state-cursor '("salmon1" box)
      evil-default-cursor t
      evil-want-visual-char-semi-exclusive t
      evil-move-cursor-back nil
      evil-want-C-u-scroll t
      evil-ex-hl-update-delay 0.01)

(evil-mode)
(evil-escape-mode)
(global-evil-leader-mode)
(global-evil-snipe-mode)
(evil-surround-mode)
(evil-exchange-install)
