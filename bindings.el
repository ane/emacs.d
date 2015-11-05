
;; Disable fill column shit fuck
(global-unset-key (kbd "C-x f"))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-h") 'windmove-left) 
(global-set-key (kbd "C-S-SPC") 'company-complete)

(global-set-key (kbd "C-o") 'vi-open-line-below)
(global-set-key (kbd "C-S-o") 'vi-open-line-above)

(global-set-key (kbd "H-f") 'projectile-find-file)
(global-set-key (kbd "H-x") 'projectile-persp-switch-project)

(defvar flymake-mode-map (make-sparse-keymap))
(define-key flymake-mode-map (kbd "S-<next>") 'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "S-<prior>") 'flymake-goto-prev-error)
(or (assoc 'flymake-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
          (cons (cons 'flymake-mode flymake-mode-map)
                minor-mode-map-alist)))

(add-hook 'flycheck-mode-hook
  (lambda ()
    (define-key flycheck-mode-map (kbd "S-<next>") 'flycheck-next-error)
    (define-key flycheck-mode-map (kbd "S-<prior>") 'flycheck-previous-error)))

;; make CxCm act as M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)

;; i don't need öäå
(global-set-key (kbd "ö") "[")
(global-set-key (kbd "ä") "]")
(global-set-key (kbd "Ö") "{")
(global-set-key (kbd "Ä") "}")
(global-set-key (kbd "<M-S-dead-circumflex>") "M-^")

(global-set-key (kbd "C-M-j") 'delete-indentation)

;; yeah, I hate myself
(mapc 'global-unset-key [[up] [down] [left] [right]])

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'hyper) ; Menu/App key

(global-set-key [f4] 'speedbar-get-focus)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
