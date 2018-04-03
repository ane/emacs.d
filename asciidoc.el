;;; package --- asdf adf

;;; Commentary:

;;; Code:
(defgroup asciidoc nil
  "Major mode for AsciiDoc files."
  :prefix "asciidoc-"
  :group 'wp)

(defgroup asciidoc-faces nil
  "AsciiDoc mode faces."
  :group 'asciidoc
  :group 'faces)

(defface asciidoc-bold-face
  '((t (:inherit bold)))
  "Face for bold text."
  :group 'asciidoc-faces)

(defface asciidoc-italic-face
  '((t (:inherit italic)))
  "Face for italic text."
  :group 'asciidoc-faces)

(defface asciidoc-heading-1-face
  '((t (:inherit outline-1)))
  "Face for level 1 headings."
  :group 'asciidoc-faces)

(defface asciidoc-heading-2-face
  '((t (:inherit outline-2)))
  "Face for level 2 headings."
  :group 'asciidoc-faces)

(defface asciidoc-heading-3-face
  '((t (:inherit outline-3)))
  "Face for level 3 headings."
  :group 'asciidoc-faces)

(defface asciidoc-heading-4-face
  '((t (:inherit outline-4)))
  "Face for level 4 headings."
  :group 'asciidoc-faces)

(defface asciidoc-heading-5-face
  '((t (:inherit outline-5)))
  "Face for level 5 headings."
  :group 'asciidoc-faces)

(defface asciidoc-heading-6-face
  '((t (:inherit outline-6)))
  "Face for level 6 headings."
  :group 'asciidoc-faces)

(defface asciidoc-metadata-face
  '((t (:inherit font-lock-preprocessor-face)))
  "Face for metadata."
  :group 'asciidoc-faces)

(defface asciidoc-inline-code-face
  '((t (:inherit (list font-lock-constant-face))))
  "Face for inline code."
  :group 'asciidoc-faces)

(defface asciidoc-anchor-face
  '((t (:inherit link)))
  "Face for anchors."
  :group 'asciidoc-faces)

(defface asciidoc-role-face
  '((t (:inherit font-lock-string-face)))
  "Face for roles."
  :group 'asciidoc-faces)

(defface asciidoc-function-face
  '((t (:inherit font-lock-function-name-face)))
  "Face for blocks like anchor:: or image::."
  :group 'asciidoc-faces)

(defface asciidoc-link-face
  '((t (:inherit link)))
  "Face for links"
  :group 'asciidoc-faces)

(defvar asciidoc-font-lock-keywords
  '(("\\(\\*\\)\\(.*?\\)\\1" . ((2 'asciidoc-bold-face)))
    ("\\(_\\)\\(.*?\\)\\1" . ((2 'asciidoc-italic-face)))
    ("^=\s.*$" . 'asciidoc-heading-1-face)
    ("^==\s.*$" . 'asciidoc-heading-1-face)
    ("^===\s.*$" . 'asciidoc-heading-3-face)
    ("^====\s.*$" . 'asciidoc-heading-4-face)
    ("^=====\s.*$" . 'asciidoc-heading-5-face)
    ("^======\s.*$" . 'asciidoc-heading-6-face)
    ("\\:[a-z\\-]+\\:" . 'asciidoc-metadata-face)
    ("`.*`" . 'asciidoc-inline-code-face)
    ("\\[\\(#.*\\)\\.\\(.*\\)\\]" . ((1 'asciidoc-anchor-face)
                                     (2 font-lock-keyword-face nil t)))
    ("\\[\\[.*\\]\\]" . 'asciidoc-anchor-face)
    ("\\[.*\\]" . 'asciidoc-role-face)
    ("\\[\\|\\]" . 'asciidoc-role-face)
    ("<<\\|>>" . 'asciidoc-builtin-face)
    ("<<\\([a-z\-]+\\)\\,?\\([a-z\-]+\\)?>>" . ((1 'asciidoc-anchor-face)
                                                (2 font-lock-string-face nil t)))
    ("\\([a-z\-]+\\)::\\([^\\[]+\\)" . ((1 'asciidoc-function-face)
                                        (2 font-lock-variable-name-face)))
    ))


(defvar asciidoc-mode-syntax-table
  (let ((table (make-syntax-table text-mode-syntax-table)))
    table))

(defun asciidoc-ensure-font-lock ()
  "Emacs 24. compatibility"
  (if (fboundp 'font-lock-ensure)
      (font-lock-ensure)
    (with-no-warnings
      ;; Suppress warning about non-interactive use of
      ;; `font-lock-fontify-buffer' in Emacs 25.
      (font-lock-fontify-buffer))))

;;;###autoload
(define-derived-mode asciidoc-mode text-mode "AsciiDoc"
  :syntax-table asciidoc-mode-syntax-table
  (setq font-lock-defaults '(asciidoc-font-lock-keywords
                             nil nil nil nil
                             (font-lock-multiline . t)))
  (asciidoc-ensure-font-lock))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.asciidoc\\'" . asciidoc-mode) t)
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.adoc\\'" . asciidoc-mode) t)

;;; asciidoc.el ends here
