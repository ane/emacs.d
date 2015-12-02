;; modeline

(use-package smart-mode-line) 
(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^~/quicklisp/local-projects/" "QL::"))
