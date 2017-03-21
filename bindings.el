
;; bindings
;; Disable fill column shit fuck
;;{{{
(global-unset-key (kbd "C-x f"))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-h") 'windmove-left) 
(global-set-key (kbd "C-o") 'vi-open-line-below)
(global-set-key (kbd "C-S-o") 'vi-open-line-above)

(global-set-key (kbd "H-f") 'projectile-find-file)
(global-set-key (kbd "H-x") 'projectile-persp-switch-project)

(add-hook 'paredit-mode-hook (lambda ()
                               (define-key paredit-mode-map (kbd "M-l") 'paredit-backward-barf-sexp)
                               (define-key paredit-mode-map (kbd "M-;") 'paredit-backward-slurp-sexp)
                               (define-key paredit-mode-map (kbd "M-'") 'paredit-forward-slurp-sexp)
                               (define-key paredit-mode-map (kbd "M-\\") 'paredit-forward-barf-sexp)))

;; make CxCm act as M-x
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

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

(global-set-key [f8] 'neotree-toggle)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(windmove-default-keybindings)

;;}}}
