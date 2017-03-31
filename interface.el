(column-number-mode t)
(show-paren-mode 1)
(global-font-lock-mode t)
(global-hl-line-mode -1)
(winner-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(rainbow-mode)

(setq custom-file "~/.emacs.d/custom.el")

(setq display-time-24hr-format t
      display-time-default-load-average nil
      info-use-header-line nil
      cursor-type 'bar
      calendar-week-start-day 1
      auto-save-default nil
      company-tooltip-align-annotations t
      initial-scratch-message nil
      isearch-lazy-highlight nil
      linum-format "%3d "
      show-trailing-whitespace t
      uniquify-buffer-name-style 'forward
      uniquify-ignore-buffers-re "^\\*"
      visible-bell t
      x-underline-at-descent-line t
      xterm-mouse-mode t)

(setq-default indent-tabs-mode nil)
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
(setq speedbar-frame-parameters '((minibuffer)
                                  (width . 40)
                                  (border-width . 0)
                                  (menu-bar-lines . 0)
                                  (tool-bar-lines . 0)
                                  (unsplittable . t)
                                  (left-fringe . 0)))
(setq ns-right-alternate-modifier nil)

(setq neo-window-position 1)
(setq neo-theme 'arrow)
(setq neo-smart-open t)

(add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

;; company stuf

;;(deftheme ane "my theme")

;; (let (
;;       (indigofera-white         (if (display-graphic-p) "#ffffff"        "white"))
;;       (indigofera-dark          (if (display-graphic-p) "#000D0D"        "navy"))
;;       (indigofera-dark1         (if (display-graphic-p) "#333399"        "MidnightBlue"))
;;       (indigofera-bright4       (if (display-graphic-p) "#006FF4"        "DarkSlateGray4"))
;;       (indigofera-red3          (if (display-graphic-p) "#E325FD"        "LightSalmon"))
;;       (indigofera-yellow2       (if (display-graphic-p) "#E2FF21"        "chartreuse1")))
;;   (custom-theme-set-faces
;;    'ane
;;    ;; `(default ((t (:foreground ,indigofera-white :background ,indigofera-dark))))
;;    ;;`(font-lock-string-face ((t (:foreground ,indigofera-red3))))
;;    ;;`(font-lock-keyword-face ((t (:foreground ,indigofera-bright4))))
;;    ;;`(font-lock-comment-face ((t (:foreground ,indigofera-yellow2))))
;;    ;; `(font-lock-type-face ((t (:foreground ,indigofera-))))
   
;;    `(region         ((t (:background ,indigofera-dark1 :distant-foreground ,indigofera-white))))
;;    `(aw-leading-char-face ((t (:foreground "red" :height 2.0))))
;;    `(company-tooltip ((t (:background "#030B1C"  :foreground ,indigofera-white))))
;;    `(company-scrollbar-bg ((t (:background "DimGrey"))))
;;    `(company-scrollbar-fg ((t (:background "cyan1"))))
;;    `(company-tooltip-selection ((t (:background "#05436C" :foreground ,indigofera-white))))
;;    '(company-tooltip-common-selection ((t (:foreground "salmon" :inherit company-tooltip-selection))))
;;    '(company-tooltip-common ((t (:foreground "salmon" :inherit company-tooltip))))
;;    '(company-tooltip-annotation ((t (:foreground "LightSkyBlue" :inherit company-tooltip))))
;;    '(company-preview ((t (:foreground "white" :inherit company-tooltip))))
;;    '(company-preview-common ((t (:foreground "salmon" :background "transparent"))))
;;    '(company-tooltip-search ((t (:inherit company-tooltip-common))))))

(require 'spaceline-config)
(spaceline-spacemacs-theme)
(setq powerline-default-separator 'arrow)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)                              ; when a daemon, invoke theme startup 
(setq spaceline-workspace-numbers-unicode t)
(setq spaceline-window-numbers-unicode t)
(load-theme 'grandshell t)

(defun setup-interface ()
  (interactive)
  (let ((font-size (pcase window-system
                     ('x 13.0)
                     ('ns 15.0))))
    (message (format "The font size is %s" font-size))
    (set-default-font (font-spec :family "Source Code Pro" :weight 'medium :size font-size)))
  (global-evil-leader-mode +1)
  (evil-escape-mode +1)
  (smooth-scrolling-mode)
  (evil-mode +1)
  (global-hl-line-mode)
  (setq browse-url-browser-function 'browse-url-default-browser)
  (projectile-global-mode +1))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (setup-interface)))

(setup-interface)
;;; interface.el ends here

