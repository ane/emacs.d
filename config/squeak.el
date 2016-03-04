(require 's)
(require 'go-mode)

(defun squeak--inside-test-file-p ()
  (string-match "_test\\.go" buffer-file-truename))

(defun squeak--get-test-name ()
  (when (go--in-function-p (point))
    (save-excursion
      (go-goto-function-name)
      (let ((name (symbol-name (symbol-at-point))))
        (when (s-prefix-p "Test" name)
          name)))))

(defun squeak--execute-test (name)
  (let* ((go-command (executable-find "go"))
         (output-buffer-name "*squeak-test*")
         (errors-buffer-name "*squeak-errors*")
         (arguments `("test" "-v" "-run" ,name))
         (full-command (s-join " " (append `(,go-command) arguments))))
    ; clear output and error buffers
    (dolist (bufname `(,output-buffer-name ,errors-buffer-name))
            (when (get-buffer bufname)
              (kill-buffer bufname)))
    (let ((output-buffer (get-buffer-create output-buffer-name))
          (errors-buffer (get-buffer-create errors-buffer-name)))
      (shell-command full-command output-buffer errors-buffer)
      (if (< 0 (buffer-size (get-buffer errors-buffer-name)))
          (progn
            (setq result "Could not run the tests. Make sure you're in the right directory."))
        (with-current-buffer output-buffer
          (let* ((target (format "--- PASS: %s \\(([^\\)]+?)\\)" name)))
            (message (format "regexp is %s" target))
            (when (string-match target (buffer-string))
              (setq
               result
               (format "Successfully ran %s in %s." name (s-chop-prefix " (" (match-string 1))))))))))
  result)

(defun squeak-run-test-under-point ()
  "Runs the"
  (interactive)
  (if (squeak--inside-test-file-p)
      (let ((test-name (squeak--get-test-name)))
        (if test-name
            (message (format "Found test: %s" test-name))
          (message "Not in a test.")))
    (message "Not inside a test file.")))


