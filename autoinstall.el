
;(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
;(add-to-list 'package-pinned-packages '(geiser . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(evil-escape . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(smex . "melpa-stable") t)

(defvar autoinstall-packages
  '(
    ace-window
    atom-one-dark-theme
    cider
    clj-refactor
    clojure-mode
    clojure-mode-extra-font-locking
    company
    company-go
    company-tern
    ensime
    evil
    evil-escape
    evil-exchange
    evil-leader
    evil-snipe
    evil-surround
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
    inf-ruby
    js2-mode
    js2-refactor
    magit
    markdown-mode+
    merlin
    persp-projectile
    perspective
    projectile
    projectile-rails
    racer
    racket-mode
    rainbow-delimiters
    rainbow-mode
    robe
    rust-mode
    ruby-block
    ruby-refactor
    rvm
    s
    color-theme-sanityinc-tomorrow
    scala-mode2
    smex
    smooth-scrolling
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
