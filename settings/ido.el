(use-package 'flx-ido)
(use-package 'ido-ubiquitous)
(use-package 'ido-vertical-mode)

(ido-mode t)
(ido-vertical-mode t)
(ido-everywhere t)
(ido-ubiquitous t)
(flx-ido-mode t)

(setq ido-auto-merge-work-directories-length 1
      ido-create-new-buffer 'always
      ido-enable-flex-matching t
      ido-ignore-buffers `("\\` "
                           "^\\*Buffer List\\*"
                           "^\\*Compile-Log\\*"
                           "^\\*Completions\\*"
                           "^\\*Helm"
                           "^\\*Help\\*"
                           "^\\*Ido"
                           "^\\*Messages\\*"
                           "^\\*RE-Builder\\*"
                           "^\\*Shell Command Output\\*"
                           "^\\*Warnings\\*"
                           "^\\*XML Validation Header\\*"
                           "^\\*growl\\*"
                           "^\\*helm"
                           "^\\*magit"
                           "TAGS"
                           (lambda (name)
                             (save-excursion
                               (equal major-mode 'dired-mode))))
      ido-use-filename-at-point nil
      ido-use-virtual-buffers nil)

(add-to-list 'ido-ignore-files "\\.DS_Store")
(add-to-list 'ido-ignore-files "Icon$")
