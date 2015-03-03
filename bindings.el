;; Disable fill column shit fuck
(global-unset-key (kbd "C-x f"))
;; Disable shit buffer gui
(global-unset-key (kbd "C-x C-b"))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-h") 'windmove-left) 
(global-set-key (kbd "C-S-SPC") 'company-complete)

(defun vi-open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

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

(defun go-jump-to-func ()
  (interactive)
  (imenu "func"))

(add-hook 'go-mode-hook
          (lambda ()
            (define-key go-mode-map (kbd "C-.") 'go-jump-to-func)))

;; make CxCm act as M-x
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)

;; i don't need öäå
(global-set-key (kbd "ö") "[")
(global-set-key (kbd "ä") "]")
(global-set-key (kbd "Ö") "{")
(global-set-key (kbd "Ä") "}")

(global-set-key (kbd "C-M-j") 'delete-indentation)
