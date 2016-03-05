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

(defun squeak--parse-results (result)
  (cond ((string-match "^ok\s+\t+.+?\t\\(.+\\)$" result)
         `((success . ,(s-trim (match-string 1)))))
        ((string-match "^FAIL\t+.+?\t\\(.+\\)$" result)
         `((failure . ,(s-trim (match-string 1)))))))

(defconst pass-regexp-with-capture "--- PASS: %s \\(([^\\)]+?)\\)")
(defconst fail-regexp-with-capture "--- FAIL: %s \\(([^\\)]+?)\\)")

(defun squeak--get-test-results (result &optional test)
  (let* ((test-name   (or test ""))
         (pass-regexp (format pass-regexp-with-capture test-name))
         (fail-regexp (format fail-regexp-with-capture test-name)))
    (cond ((string-match pass-regexp result)
           `((success . ,(s-chop-prefix " (" (match-string 1)))))
          ((string-match fail-regexp result)
           `((failure . ,(s-chop-prefix " (" (match-string 1))))))))

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
                    (squeak--get-test-results (buffer-string) test)  
                  (squeak--parse-results (buffer-string)))))))
      '(err . (format "`%s' command not found in PATH!" go-executable-name)))))


(defun squeak--report-result (result &optional name)
  (cond ((assq 'success result)
         (let ((time (cdr (assq 'success result))))
           (message (if (s-present? name)
                        (format "Test %s passed in %s." name time)
                      (format "All tests passed in %ss." time)))))
        ((assq 'failure result)
         (let ((time (cdr (assq 'failure result))))
           (message (if (s-present? name)
                        (format "Test %s failed in %s." name time)
                      (format "Not all tests passed in %ss." time)))))))

(defun squeak-run-test-under-point ()
  "Runs the test under point."
  (interactive)
  (if (squeak--inside-test-file-p)
      (let ((test-name (squeak--get-test-name)))
        (if test-name
            (let ((result (squeak--run-go-test test-name)))
              (message nil)
              (squeak--report-result result test-name))
          (message "Not inside a test.")))
    (message "Not inside a test file.")))

(defun squeak-run-tests-for-package ()
  "Runs all the tests in the directory of the current buffer."
  (interactive)
  (if (directory-files (file-name-directory (buffer-file-name)) "_test\\.go$")
      (progn
        (let ((result (squeak--run-go-test)))
          (message nil)
          (squeak--report-result result)))
    (message "No test files found in the current directory.")))
