(package-initialize)


;;;;;;;;;;;;;;;;;;;;; REQUIRE ;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(require 'doom-themes)
(require 'doom-modeline)
(require 'evil)
(require 'clj-refactor)
(require 'ac-cider)
(require 'auto-complete)
(require 'cider)
(use-package clojure-mode
  :ensure t
  :config
  (require 'flycheck-clj-kondo))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
   '("615123f602c56139c8170c153208406bf467804785007cdc11ba73d18c3a248b" default))
 '(initial-buffer-choice t))

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
(set-face-attribute 'default nil
                    :family "Inconsolata"
                    :height 130
                    :weight 'normal
                    :width 'normal)
(customize-set-variable
 'minibuffer-prompt-properties
 (quote (read-only t cursor-intangible t face minibuffer-prompt)))
;;;;;;;;;;;;;;;;;;;;;; HELM ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)

;;;;;;;;;;;;;;;;;;;;;; HOOKS ;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clojure-auto-complete-hook ()
  (auto-complete-mode 1))

(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-interaction-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'clojure-mode-hook 'clojure-auto-complete-hook)
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq package-list '(helm
                     helm-projectile
                     helm-ag))

(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")

