(add-hook 'elixir-mode-hook
          (lambda ()
            (company-mode)
            (alchemist-mode)))

(add-hook 'alchemist-iex-mode-hook
          (lambda ()
            (company-mode)))
