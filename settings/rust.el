(add-hook 'speedbar-load-hook (lambda ()
                                (push ".rs" speedbar-supported-extension-expressions)))

(setq racer-rust-src-path "~/Downloads/rust/src/")
(setq racer-cmd "~/Downloads/racer/target/release/racer")
(add-to-list 'load-path "~/Downloads/racer/editors/")
(eval-after-load "rust-mode" '(require 'racer))

(add-hook 'rust-mode-hook
          (lambda ()
            (use-package racer)
            (smartparens-mode)
            (rainbow-delimiters-mode)
            (flycheck-mode)
            (flycheck-rust-setup)))

(sp-local-pair 'rust-mode "'" nil :actions nil)
