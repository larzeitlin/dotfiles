

;;;;;;;;;;;;;;;;;;;;; REQUIRE ;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(package-initialize)

(defvar my-packages '(doom-themes
                      clojure-mode
                      doom-modeline
                      evil
                      clj-refactor
                      ac-cider
                      flycheck-clj-kondo
                      auto-complete
                      cider))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (print (format "Installing %s" p))
    (package-install p)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t) ;; No splash screen
(setq initial-scratch-message nil) ;; No scratch message


(defvar user-temporary-file-directory "~/.emacs-backup")
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t) 
(setq backup-directory-alist 
      `(("." . ,user-temporary-file-directory)
	(,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "615123f602c56139c8170c153208406bf467804785007cdc11ba73d18c3a248b" default)))
 '(initial-buffer-choice t)
 '(minibuffer-prompt-properties
   (quote
    (read-only t cursor-intangible t face minibuffer-prompt)))
 '(package-selected-packages
   (quote
    (rainbow-delimiters clojure-mode-extra-font-locking paredit-menu helm flycheck-clj-kondo evil doom-themes doom-modeline company clj-refactor aggressive-indent ac-cider))))

;;;;;;;;;;;;;;;;; DOOM THEME ;;;;;;;;;;;;;;;;;;;;;;;;;
(setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
      doom-themes-enable-italic nil) ; if nil, italics is universally disabled
(doom-themes-visual-bell-config)
(doom-themes-org-config)
(load-theme 'doom-spacegrey)
(doom-modeline-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;; GLOBAL MODES ;;;;;;;;;;;;;;;;;;;;;
(global-flycheck-mode)
(global-company-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;;;;;;;;;;;;;;;;;;;;; UI ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(tool-bar-mode -1)
(setq mode-line-format nil)
(global-hl-line-mode +1)
(global-visual-line-mode 1)
(setq display-line-numbers 'relative)
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
(setq show-paren-style 'expression)
(customize-set-variable
 'minibuffer-prompt-properties
 (quote (read-only t cursor-intangible t face minibuffer-prompt)))
(setq custom-safe-themes t)
;;;;;;;;;;;;;;;;;;;;;; HELM ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)

;;;;;;;;;;;;;;;;;;;;;; PARENS ;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-repl-mode-hook 'paredit-mode)
(add-hook 'clojure-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojurescript-mode-hook 'paredit-mode)
(add-hook 'clojurescript-mode-hook 'rainbow-delimiters-mode)

;;;;;;;;;;;;;;;;;; EDIT SETTINGS ;;;;;;;;;;;;;;;;;;;;;;
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
(global-display-line-numbers-mode)
(show-paren-mode 1)
(evil-mode 1)
(define-key evil-normal-state-map (kbd "M-.") nil)

;;;;;;;;;;;;;;;;;;;;;; CIDER ;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-popup-stacktraces nil)

;;;;;;;;;;;;;;;;;; AUTOCOMPLETE ;;;;;;;;;;;;;;;;;;;;;;;
(ac-config-default)
(add-to-list 'ac-modes 'cider-mode)
(add-to-list 'ac-modes 'cider-repl-mode)
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")

(setq cider-show-error-buffer nil)
(setq cider-save-file-on-load t)

(require 'expand-region)
(global-set-key (kbd "<M-s-up>") 'er/expand-region)
(global-set-key (kbd "<M-s-down>") 'er/contract-region)
(global-set-key (kbd "<M-s-right>") 'paredit-forward)
(global-set-key (kbd "<M-s-left>") 'paredit-backward)
(global-set-key (kbd "M-s-c") 'lsp-format-region)
(global-set-key (kbd "M-s-r") 'paredit-raise-sexp)
(global-set-key (kbd "M-s-b") 'paredit-wrap-round)
(global-set-key (kbd "M-s-[") 'paredit-wrap-square)
(global-set-key (kbd "M-s-{") 'paredit-wrap-curly)
(global-set-key (kbd "M-s-k") 'paredit-kill)
