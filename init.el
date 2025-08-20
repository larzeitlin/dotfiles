;; Literate Emacs Configuration
;; This file tangles and loads configuration from config.org

(require 'org)
(org-babel-load-file (expand-file-name "config.org" (file-name-directory (or load-file-name buffer-file-name))))