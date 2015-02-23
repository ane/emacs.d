;;(define-key evil-insert-state-map [left] 'undefined)
;;(define-key evil-insert-state-map [right] 'undefined)
;;(define-key evil-insert-state-map [up] 'undefined)
;;(define-key evil-insert-state-map [down] 'undefined)
;;
;;(define-key evil-motion-state-map [left] 'undefined)
;;(define-key evil-motion-state-map [right] 'undefined)
;;(define-key evil-motion-state-map [up] 'undefined)
;;(define-key evil-motion-state-map [down] 'undefined)

;; enable vim bindings?
;;(evil-mode 1)


;; Disable fill column shit fuck
(global-unset-key (kbd "C-x f"))
;; Disable shit buffer gui
(global-unset-key (kbd "C-x C-b"))

(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-h") 'windmove-left) 

;;(define-key evil-normal-state-map (kbd ",x") 'transpose-frame)
;;(define-key evil-normal-state-map (kbd ",f") 'projectile-find-file)
;;(define-key evil-normal-state-map (kbd ",b") 'projectile-switch-to-buffer)
;;(define-key evil-normal-state-map (kbd ",l") 'projectile-find-file-in-directory)
;;(define-key evil-normal-state-map (kbd ",t") 'projectile-find-test-file)
;;(define-key evil-normal-state-map (kbd ",,") 'projectile-recentf)

(global-set-key (kbd "C-S-SPC") 'company-complete)

(global-set-key (kbd "C-l") 'paredit-backward-barf-sexp)
(global-set-key (kbd "C-ö") 'paredit-backward-slurp-sexp)
(global-set-key (kbd "C-ä") 'paredit-forward-slurp-sexp)
(global-set-key (kbd "C-'") 'paredit-forward-barf-sexp)

(defun vi-open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (interactive)  
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(global-set-key (kbd "C-o") 'vi-open-line-below)
(global-set-key (kbd "C-S-o") 'vi-open-line-above)



