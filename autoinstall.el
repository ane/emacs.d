(add-to-list 'package-pinned-packages '(evil-escape . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(smex . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(projectile . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(helm-projectile . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(helm . "melpa-stable") t)
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
    counsel
    diminish
    doom-themes
    evil
    evil-escape
    evil-leader
    exec-path-from-shell
    f
    flycheck
    flycheck-clojure
    flycheck-haskell
    flycheck-pos-tip
    geiser
    haskell-mode
    helm
    helm-ag
    helm-projectile
    hi2
    ivy
    kaolin-themes
    magit
    magit-gitflow
    markdown-mode+
    org-journal
    persp-projectile
    perspective
    projectile
    rainbow-delimiters
    rainbow-mode
    racket-mode
    s
    color-theme-sanityinc-tomorrow
    scala-mode
    smooth-scrolling
    spaceline
    sr-speedbar
    transpose-frame
    web-mode
    zenburn-theme)
  "A list of packages to ensure are installed at launch.")

(when (--any? (not (package-installed-p it)) autoinstall-packages)
  (message "%s" "Emacs is now refreshing its package database...")
  (unless refreshed
    (package-refresh-contents)
    (setq refreshed t))
  (message "%s" " done.")
  ;; check for new packages (package versions)
  ;; install the missing packages
  (dolist (p autoinstall-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'autoinstall)
