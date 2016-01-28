(deftheme ane "my theme") 

(custom-theme-set-faces
 'ane
 '(font-lock-keyword-face ((t (:foreground "DarkMagenta" :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "MediumBlue"))))
 '(font-lock-comment-face ((t (:foreground "DarkSlateGray4"))))
 '(font-lock-doc-face ((t (:foreground "MistyRose4"))))
 '(font-lock-type-face ((t (:foreground "cyan4"))))
 '(font-lock-string-face ((t (:foreground "DarkBlue"))))
 '(font-lock-variable-name-face ((t (:foreground "forest green")))))

(provide-theme 'ane)
