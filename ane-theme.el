(deftheme ane "my theme") 

(custom-theme-set-faces
 'ane
 '(font-lock-keyword-face ((t (:foreground "magenta4"))))
 '(font-lock-function-name-face ((t (:foreground "MediumBlue"))))
 '(font-lock-comment-face ((t (:foreground "thistle4"))))
 '(font-lock-builtin-face ((t (:foreground "brown3"))))
 '(font-lock-doc-face ((t (:foreground "MistyRose4"))))
 '(font-lock-type-face ((t (:foreground "blue"))))
 '(font-lock-constant-face ((t (:foreground "RoyalBlue4"))))
 '(font-lock-string-face ((t (:foreground "DarkOrange4"))))
 '(font-lock-variable-name-face ((t (:foreground "DarkCyan"))))
 '(clojure-keyword-face ((t (:foreground "forest green"))))
 '(show-paren-match ((t (:foreground "magenta" :weight bold ))))
 '(show-paren-mismatch ((t (:foreground "white" :background "red"))))
 '(powerline-active1 ((t (:background "DarkViolet" :foreground "white" :inherit mode-line-inactive))))
 '(powerline-active2 ((t (:background "seashell1" :inherit mode-line-inactive))))
 '(powerline-inactive1 ((t (:background "bisque1" :inherit mode-line-inactive))))
 '(hl-line ((t (:background "cornsilk"))))
 '(powerline-inactive2 ((t (:background "gainsboro" :inherit mode-line-inactive)))))

(provide-theme 'ane)
