;; early-init.el --- Early initialization file

;; Disable package.el in favor of package initialization in init.el
(setq package-enable-at-startup nil)

;; Increase garbage collection threshold for faster startup
(setq gc-cons-threshold most-positive-fixnum)

;; Restore normal GC threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))))

;; Disable file-name-handler-alist during startup for better performance
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-original)))

;; Native compilation settings (Emacs 28+)
(when (featurep 'native-compile)
  (setq native-comp-async-report-warnings-errors nil)
  (setq native-comp-deferred-compilation t))