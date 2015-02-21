(require-package 'projectile)
(require-package 'company)
(require-package 'omnisharp)
(require-package 'flycheck)
(require-package 'rainbow-delimiters)

(setq omnisharp-server-executable-path "C:/Users/Ane/OmniSharp/server/Omnisharp/bin/Debug/OmniSharp.exe")

(add-hook 'csharp-mode-hook
          (lambda ()
            (omnisharp-mode)
            (projectile-mode)
            (subword-mode)
            (flycheck-mode)
            (rainbow-delimiters-mode)
            (add-to-list 'company-backends 'company-omnisharp)
            (company-mode)
            ))

(defun reformat-csharp-code ()
  (interactive)
  (omnisharp-code-format)
  (save-excursion (goto-char (point-min))
                  (while (search-forward "\r" nil t)
                    (replace-match "" nil t))))

(defun csharp-keybindings ()
  (interactive)
  (local-set-key (kbd "<f6>") 'omnisharp-build-in-emacs)
  (local-set-key (kbd "C-c f f") 'reformat-csharp-code)
  (local-set-key (kbd "C-c f d") 'omnisharp-go-to-definition)
  (local-set-key (kbd "C-c f u") 'omnisharp-find-usages)
  (local-set-key (kbd "C-c f i") 'omnisharp-find-implementations)
  (local-set-key (kbd "C-c f n") 'omnisharp-rename)
  (local-set-key (kbd "C-c f N") 'omnisharp-rename-interactively))

;; keybindings for csharp mode, to mimic visual studio
;; where applicable
(add-hook 'csharp-mode-hook 'csharp-keybindings)
