(add-hook 'speedbar-load-hook (lambda ()
                                (push ".rs" speedbar-supported-extension-expressions)))

(setq racer-cmd "~/Downloads/racer/target/release/racer")
(setq racer-rust-src-path "~/Downloads/rustc-1.3.0/src")

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(add-hook 'rust-mode-hook
          (lambda ()
            (use-package flycheck-rust)
            (setq company-tooltip-align-annotations t)
            (smartparens-mode)
            (rainbow-delimiters-mode)
            (flycheck-mode)
            (flycheck-rust-setup)))

(sp-local-pair 'rust-mode "'" nil :actions nil)
