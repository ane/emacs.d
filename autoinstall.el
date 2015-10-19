
;(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(company . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(evil-escape . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(smex . "melpa-stable") t)

(defvar autoinstall-packages
  '(
    ace-window
    cider
    clj-refactor
    clojure-mode
    clojure-mode-extra-font-locking
    company
    company-go
    evil
    evil-escape
    evil-exchange
    evil-leader
    evil-smartparens
    evil-snipe
    evil-surround
    f
    flx-ido
    flycheck
    flycheck-clojure
    flycheck-haskell
    flycheck-ocaml
    flycheck-pos-tip
    flycheck-rust
    go-eldoc
    go-mode
    go-projectile
    haskell-mode
    hl-sexp
    ido-hacks
    ido-ubiquitous
    ido-vertical-mode
    magit
    markdown-mode+
    merlin
    persp-projectile
    perspective
    projectile
    racer
    racket-mode
    rainbow-delimiters
    rainbow-mode
    rust-mode
    s
    smart-mode-line
    smartparens
    smex
    smooth-scrolling
    sr-speedbar
    transpose-frame
    tuareg
    zenburn-theme
    )
  "A list of packages to ensure are installed at launch.")

(when (--any? (not (package-installed-p it)) autoinstall-packages)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; check for new packages (package versions)
  ;; install the missing packages
  (dolist (p autoinstall-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'autoinstall)
