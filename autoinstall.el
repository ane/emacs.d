(add-to-list 'package-pinned-packages '(evil-escape . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(smex . "melpa-stable") t)

(defvar autoinstall-packages
  '(
    ace-window
    aggressive-indent
    cider
    clj-refactor
    clojure-mode
    clojure-mode-extra-font-locking
    company
    company-go
    company-ghc
    company-tern
    evil
    evil-escape
    evil-exchange
    evil-leader
    evil-snipe
    evil-surround
    evil-vimish-fold
    f
    flycheck
    flycheck-clojure
    flycheck-haskell
    flycheck-ocaml
    flycheck-pos-tip
    flycheck-rust
    geiser
    go-eldoc
    go-mode
    go-projectile
    haskell-mode
    helm
    helm-ag
    helm-projectile
    hi2
    js2-mode
    js2-refactor
    magit
    magit-gitflow
    markdown-mode+
    merlin
    persp-projectile
    perspective
    projectile
    racer
    rainbow-delimiters
    rainbow-mode
    s
    color-theme-sanityinc-tomorrow
    scala-mode
    smex
    smooth-scrolling
    spaceline
    sr-speedbar
    tern
    tide
    transpose-frame
    tuareg
    web-mode
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
