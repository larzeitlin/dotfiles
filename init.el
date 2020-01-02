(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'doom-themes)
(setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
      doom-themes-enable-italic nil) ; if nil, italics is universally disabled
(doom-themes-visual-bell-config)
(doom-themes-org-config)

;;hooks
(print "Adding hooks")
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojurescript-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojurescript-mode-hook 'paredit-mode)

;no popup when cider jacks in
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-popup-stacktraces nil)


(global-display-line-numbers-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(setq mode-line-format nil)
(ac-config-default)
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
(global-hl-line-mode +1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(require 'evil)
(evil-mode 1)
(require 'doom-modeline)
(doom-modeline-mode 1)
(global-visual-line-mode 1)
	
(setq package-list '(helm
                     helm-projectile
                     helm-ag))

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d6f04b6c269500d8a38f3fabadc1caa3c8fdf46e7e63ee15605af75a09d5441e" "c8f959fb1ea32ddfc0f50db85fea2e7d86b72bb4d106803018be1c3566fd6c72" default)))
 '(initial-buffer-choice t)
 '(package-selected-packages
   (quote
    (projectile rainbow-delimiters paredit ox-reveal org-bullets magit htmlize helm evil doom-themes doom-modeline doom cmake-ide cider))))

(load-theme 'doom-spacegrey)

(require 'clj-refactor)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(require 'cider)
(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")

(require 'cider)
(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'cider-interaction-mode-hook 'cider-turn-on-eldoc-mode)

(global-company-mode)

;; minibuffer, stop cursor going into prompt
(customize-set-variable
 'minibuffer-prompt-properties
 (quote (read-only t cursor-intangible t face minibuffer-prompt)))

(setq show-paren-style 'expression)

