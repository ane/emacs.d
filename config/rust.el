(add-hook 'speedbar-load-hook (lambda ()
                                (push ".rs" speedbar-supported-extension-expressions)))

(setq racer-cmd "~/Downloads/racer/target/release/racer")
(setq racer-rust-src-path "~/Downloads/rustc-1.4.0/src")

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(add-hook 'rust-mode-hook
          (lambda ()
            (setq company-tooltip-align-annotations t)
            (rainbow-delimiters-mode)
            (flycheck-mode)))

