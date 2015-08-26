(add-hook 'speedbar-load-hook (lambda ()
                                (push ".rs" speedbar-supported-extension-expressions)))

(setq racer-cmd "~/Downloads/racer/target/release/racer")
(add-to-list 'load-path "~/Downloads/racer/editors/")

(add-hook 'rust-mode-hook
          (lambda ()
            (use-package racer)
            (use-package flycheck-rust)
            (company-mode)
            (smartparens-mode)
            (rainbow-delimiters-mode)
            (flycheck-mode)
            (flycheck-rust-setup)))

(sp-local-pair 'rust-mode "'" nil :actions nil)