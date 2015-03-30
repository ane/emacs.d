(use-package projectile)

(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")
(add-to-list 'projectile-globally-ignored-directories "node_modules")
(add-to-list 'projectile-globally-ignored-directories ".cask")
(add-to-list 'projectile-globally-ignored-directories ".cabal-sandbox")
(add-to-list 'projectile-globally-ignored-directories "build")
(add-to-list 'projectile-globally-ignored-directories "bin")
(add-to-list 'projectile-globally-ignored-directories ".git")

(setq projectile-indexing-method 'alien)
