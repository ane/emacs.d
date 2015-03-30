(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(setq haskell-stylish-on-save t)

(add-to-list 'company-backends 'company-ghc)


(defun my/setup-haskell ()
  (ghc-init)
  (flycheck-mode)
  (company-mode)
  (flycheck-haskell-setup)
  (rainbow-delimiters-mode)
  (hindent-mode)
  (turn-on-haskell-indentation)) 

(add-hook 'haskell-mode-hook 'my/setup-haskell)
