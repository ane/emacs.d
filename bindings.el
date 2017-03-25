
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
(global-set-key (kbd "C-S-SPC") 'company-complete)

(global-set-key (kbd "C-o") 'vi-open-line-below)
(global-set-key (kbd "C-S-o") 'vi-open-line-above)

(global-set-key (kbd "H-f") 'projectile-find-file)
(global-set-key (kbd "H-x") 'projectile-persp-switch-project)

(add-hook 'paredit-mode-hook (lambda ()
                               (define-key paredit-mode-map (kbd "M-l") 'paredit-backward-barf-sexp)
                               (define-key paredit-mode-map (kbd "M-;") 'paredit-backward-slurp-sexp)
                               (define-key paredit-mode-map (kbd "M-'") 'paredit-forward-slurp-sexp)
                               (define-key paredit-mode-map (kbd "M-\\") 'paredit-forward-barf-sexp)))

(add-hook 'flycheck-mode-hook
          (lambda ()
            (define-key flycheck-mode-map (kbd "S-<next>") 'flycheck-next-error)
            (define-key flycheck-mode-map (kbd "S-<prior>") 'flycheck-previous-error)))

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

(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-normal-state-map (kbd "q") nil)
(define-key evil-operator-state-map (kbd "q") nil)

(setq-default evil-symbol-word-search t)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "f" 'helm-projectile-find-file)
(evil-leader/set-key "F" 'helm-find-files)
(evil-leader/set-key "p" 'helm-projectile-switch-project)
(evil-leader/set-key "x" 'smex)
(evil-leader/set-key "s" 'yas-insert-snippet)
(evil-leader/set-key "t" 'projectile-toggle-between-implementation-and-test)
(evil-leader/set-key "T" 'projectile-find-test-file)
(evil-leader/set-key "a" 'helm-ag)
(evil-leader/set-key "g" 'magit-status)
(evil-leader/set-key "w" 'ace-window)
(evil-leader/set-key "b" 'helm-projectile-switch-to-buffer)
(evil-leader/set-key "B" 'list-buffers)
(evil-leader/set-key "i" 'helm-imenu)
(evil-leader/set-key "k" 'kill-buffer)
(evil-leader/set-key "o" 'helm-occur)
(evil-leader/set-key "h" 'previous-buffer)
(evil-leader/set-key "l" 'next-buffer)
(evil-leader/set-key "I" 'indent-region)
(evil-leader/set-key-for-mode 'js2-refactor-mode
  "r" (lambda () (discover-show-context-menu 'js2-refactor)))

(evil-leader/set-key-for-mode 'cider-mode "e" 'cider-eval-last-sexp)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-last-sexp)
(windmove-default-keybindings)

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(global-set-key [escape] 'evil-exit-emacs-state)
;;}}}
