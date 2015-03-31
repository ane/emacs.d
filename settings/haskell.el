(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(add-to-list 'company-backends 'company-ghc)

(evil-define-key 'insert haskell-interactive-mode-map (kbd "RET") 'haskell-interactive-mode-return)
(evil-define-key 'normal haskell-interactive-mode-map (kbd "RET") 'haskell-interactive-mode-return)

(add-hook 'speedbar-load-hook (lambda ()
                                (push ".hs" speedbar-supported-extension-expressions)))

(defun my/setup-haskell ()
  (ghc-init)
  (flycheck-mode)
  (eval-after-load 'flycheck
    '(require 'flycheck-hdevtools))
  (company-mode)
  (rainbow-delimiters-mode)
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indentation)) 

(add-hook 'haskell-mode-hook 'my/setup-haskell)
