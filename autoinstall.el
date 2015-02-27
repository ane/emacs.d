(defvar autoinstall-packages
  '(
    cider
    clj-refactor
    clojure-mode
    company
    company-go
    company-quickhelp
    evil
    f
    flx-ido
    flycheck
    flycheck-ocaml
    flymake-cursor
    go-mode
    go-eldoc
    go-projectile
    haskell-mode
    ido-ubiquitous
    ido-vertical-mode
    magit
    markdown-mode+
    merlin
    omnisharp
    perspective
    persp-projectile
    projectile
    s
    rainbow-delimiters
    smart-mode-line
    smartparens
    smooth-scrolling
    transpose-frame
    typescript
    tss
    tuareg
    )
  "A list of packages to ensure are installed at launch.")

(when (--any? (not (package-installed-p it)) autoinstall-packages)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p autoinstall-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'autoinstall)
