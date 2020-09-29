(defconst my/start-time (current-time))

(defvar file-name-handler-alist-old file-name-handler-alist)

(setq file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold most-positive-fixnum   ;; Defer Garbage collection
      gc-cons-percentage 1.0)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-old
                  gc-cons-threshold 800000
                  gc-cons-percentage 0.1)
            (garbage-collect)
            (message "Load time %.06f"
                     (float-time (time-since 
                                  my/start-time)))) t)

(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
