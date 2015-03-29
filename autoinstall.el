
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
    company-quickhelp
    evil
    evil-exchange
    evil-snipe
    evil-leader
    evil-smartparens
    evil-escape
    evil-surround
    f
    flx-ido
    flycheck
    flycheck-ocaml
    flycheck-clojure
    flycheck-pos-tip
    go-mode
    go-eldoc
    go-projectile
    haskell-mode
    ido-ubiquitous
    ido-vertical-mode
    ido-hacks
    magit
    markdown-mode+
    merlin
    perspective
    persp-projectile
    projectile
    s
    rainbow-delimiters
    smart-mode-line
    smartparens
    smooth-scrolling
    smex
    sr-speedbar
    transpose-frame
    tuareg
    zenburn-theme
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
