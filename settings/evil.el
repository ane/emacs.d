
(require 'evil)
(require 'evil-leader)

(setq-default evil-escape-key-sequence "jk")

;;(define-key evil-normal-state-map [escape] 'keyboard-quit)
;;(define-key evil-visual-state-map [escape] 'keyboard-quit)
;;(define-key cider-stacktrace-mode-map [escape] 'cider-popup-buffer-quit-function)
;;(define-key cider-test-report-mode-map [escape] 'cider-popup-buffer-quit-function)
;;(define-key helm-map [escape] 'helm-keyboard-quit)
;;(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;;(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;;(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;;(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;;(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-normal-state-map (kbd "q") nil)
(define-key evil-operator-state-map (kbd "q") nil)
(define-key evil-insert-state-map (kbd "<escape>") nil)

(add-hook 'smartparens-strict-mode-hook #'evil-smartparens-mode)
(setq-default evil-symbol-word-search t)

(evil-define-motion evil-little-word (count)
  :type exclusive
  (let ((case-fold-search nil))
    (forward-char)
    (search-forward-regexp "[_A-Z]\\|\\W" nil t)
    (backward-char)))

(evil-define-motion evil-little-word-backward (count)
  :type exclusive
  (let ((case-fold-search nil))
    (backward-char)
    (search-backward-regexp "[_A-Z]\\|\\W" nil t)))

(define-key evil-normal-state-map (kbd ", b") 'evil-little-word-backward)
(define-key evil-normal-state-map (kbd ", w") 'evil-little-word) 
(define-key evil-operator-state-map (kbd ", w") 'evil-little-word)
(define-key evil-operator-state-map (kbd ", b") 'evil-little-word-backward)


(evil-leader/set-leader ",")
(evil-leader/set-key "f" 'helm-projectile-find-file)
(evil-leader/set-key "p" 'helm-projectile-switch-project)
(evil-leader/set-key "t" 'projectile-find-test-file)
(evil-leader/set-key "b" 'helm-projectile-switch-to-buffer)

(evil-leader/set-key-for-mode 'cider-mode "e" 'cider-eval-last-sexp)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-last-sexp)
(global-evil-leader-mode)

(evil-mode)
(evil-escape-mode)
