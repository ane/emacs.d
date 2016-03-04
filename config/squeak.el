(require 's)
(require 'go-mode)

(defconst go-executable-name "go")

(defun squeak--inside-test-file-p ()
  (string-match "_test\\.go" buffer-file-truename))

(defun squeak--get-test-name ()
  (when (go--in-function-p (point))
    (save-excursion
      (go-goto-function-name)
      (let ((name (symbol-name (symbol-at-point))))
        (when (s-prefix-p "Test" name)
          name)))))

(defun squeak--run-go-test (&optional test)
  (let ((go-command (executable-find go-executable-name)))
    (if go-command
        (let* ((output-buffer-name "*squeak-test*")
               (errors-buffer-name "*squeak-errors*")
               (arguments '("test" "-v"))
               (full-command
                (s-join " " (append `(,go-command) arguments
                                    (when (s-present? test)
                                      `("-run" ,test))))))
          (dolist (bufname `(,output-buffer-name ,errors-buffer-name))
            (when (get-buffer bufname)
              (with-current-buffer (get-buffer bufname)
                (erase-buffer))))
          (let ((output-buffer (get-buffer-create output-buffer-name))
                (errors-buffer (get-buffer-create errors-buffer-name)))
            (shell-command full-command output-buffer errors-buffer)
            (if (< 0 (buffer-size errors-buffer))
                '(err . "could not run tests, are you in the right directory or is the build working?")
              (with-current-buffer output-buffer
                (if (s-present? test)
                    (let ((pass-regexp (format "--- PASS: %s \\(([^\\)]+?)\\)" test))
                          (fail-regexp (format "--- FAIL: %s \\(([^\\)]+?)\\)" test)))
                   (cond ((string-match pass-regexp (buffer-string))
                          (progn
                            (message "hahaa")
                            `(success . ,(s-chop-suffix "s" (s-chop-prefix " (" (match-string 1)))))
                          (string-match fail-regexp (buffer-string))
                          (progn
                            (message "bah")
                            `(failure . ,(s-chop-suffix "s" (s-chop-prefix " (" (match-string 1))))))))
                 (when (string-match "^ok\s+\t+.+?\t\\(.+\\)$" (buffer-string))
                     `(success . ,(s-trim (match-string 1)))
                   '(err . "failed")))))))
      '(err . (format "`%s' command not found in PATH!" go-executable-name)))))


(defun squeak-run-test-under-point ()
  "Runs the"
  (interactive)
  (if (squeak--inside-test-file-p)
      (let ((test-name (squeak--get-test-name)))
        (if test-name
            (let ((result (squeak--run-go-test test-name)))
              (message (symbol-name (car result)))
              (message (cdr result)))
          (message "Not inside a test.")))
    (message "Not inside a test file.")))


