(use-package projectile)

(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")
(add-to-list 'projectile-globally-ignored-directories "node_modules")
(add-to-list 'projectile-globally-ignored-directories ".cask")
(add-to-list 'projectile-globally-ignored-directories ".cabal-sandbox")
(add-to-list 'projectile-globally-ignored-directories ".python-environments")
(add-to-list 'projectile-globally-ignored-directories "build")
(add-to-list 'projectile-globally-ignored-directories "bin")
(add-to-list 'projectile-globally-ignored-directories ".git")
(add-to-list 'projectile-globally-ignored-directories "quelpa")
(add-to-list 'projectile-globally-ignored-directories ".ensime_cache")
(add-to-list 'projectile-globally-ignored-directories "target")
(add-to-list 'projectile-globally-ignored-directories "project/project")
(add-to-list 'projectile-globally-ignored-directories "project/target")

(setq projectile-indexing-method 'alien)
(helm-projectile-on)
