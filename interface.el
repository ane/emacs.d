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
      auto-save-default nil
      company-tooltip-align-annotations t
      initial-scratch-message nil
      isearch-lazy-highlight nil
      linum-format "%3d "
      show-trailing-whitespace t
      uniquify-buffer-name-style 'forward
      uniquify-ignore-buffers-re "^\\*"
      visible-bell t
      x-select-enable-clipboard t
      x-underline-at-descent-line t
      xterm-mouse-mode t)

(setq-default indent-tabs-mode nil)
(setq speedbar-show-unknown-files t)
(setq ns-right-alternate-modifier nil)

;; company stuf
(deftheme ane "my theme")
(custom-theme-set-faces
 'ane
 '(company-tooltip ((t (:background "DarkSlateGrey"))))
 '(company-scrollbar-bg ((t (:background "DimGrey"))))
 '(company-scrollbar-fg ((t (:background "cyan1"))))
 '(company-tooltip-selection ((t (:background "DarkSlateGray4"))))
 '(company-tooltip-common-selection ((t (:foreground "salmon" :inherit company-tooltip-selection))))
 '(company-tooltip-common ((t (:foreground "salmon" :inherit company-tooltip))))
 '(company-tooltip-annotation ((t (:foreground "LightSkyBlue" :inherit company-tooltip))))
 '(company-preview ((t (:foreground "white" :inherit company-tooltip))))
 '(company-preview-common ((t (:foreground "salmon" :background "transparent"))))
 '(company-tooltip-search ((t (:inherit company-tooltip-common))))
 )

(rainbow-delimiters-mode)
(load-theme 'darktooth t)
