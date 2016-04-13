(let ((my-cabal-path (expand-file-name "~/.cabal/bin"))
      (local-bin-path (expand-file-name "~/.local/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (setenv "PATH" (concat local-bin-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path)
  (add-to-list 'exec-path local-bin-path))

(evil-define-key 'insert haskell-interactive-mode-map (kbd "RET") 'haskell-interactive-mode-return)
(evil-define-key 'normal haskell-interactive-mode-map (kbd "RET") 'haskell-interactive-mode-return)

(add-hook 'speedbar-load-hook (lambda ()
                                (push ".hs" speedbar-supported-extension-expressions)))

(custom-set-variables
 '(haskell-process-suggest-hoogle-imports t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-type 'stack-ghci))

(add-to-list 'flycheck-disabled-checkers 'haskell-ghc)
(add-to-list 'flycheck-disabled-checkers 'haskell-hlint)
(evil-leader/set-key-for-mode 'haskell-mode "h b" 'haskell-interactive-bring)
(evil-leader/set-key-for-mode 'haskell-mode "h t" 'haskell-process-do-type)
(evil-leader/set-key-for-mode 'haskell-mode "h i" 'haskell-process-do-info)
(evil-leader/set-key-for-mode 'haskell-mode "h c" 'haskell-process-cabal-build)
(evil-leader/set-key-for-mode 'haskell-mode "h k" 'haskell-interactive-mode-clear)
(evil-leader/set-key-for-mode 'haskell-mode "h l" 'haskell-process-load-or-reload)

(defun my/setup-haskell ()
  (turn-on-hi2)
  (ghc-init)
  (company-mode)
  (add-to-list 'company-backends 'company-ghc)
  (flycheck-mode)
  (electric-indent-local-mode -1)
  (flycheck-haskell-setup)
  (rainbow-delimiters-mode)
  (haskell-doc-mode)
  (interactive-haskell-mode)) 


(add-hook 'haskell-mode-hook 'my/setup-haskell)
(add-hook 'haskell-interactive-mode-hook 'company-mode)
