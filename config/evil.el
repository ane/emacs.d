(use-package evil)
(use-package evil-leader)


(setq evil-insert-state-cursor '("HotPink1" (hbar . 4))
      evil-normal-state-cursor '("cyan1" box)
      evil-visual-state-cursor '("SeaGreen1" box)
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
