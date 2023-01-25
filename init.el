(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode)
(global-display-line-numbers-mode t)
(global-visual-line-mode t)
(set-face-attribute 'default nil :height 120)
(package-initialize)
(show-paren-mode)
(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq inhibit-startup-screen t)

(use-package general
  :ensure t
  :init (general-auto-unbind-keys))

(use-package evil
  :ensure t
  :config (evil-mode 1))

(use-package magit
  :ensure t
  :init (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(setq completion-styles '(flex))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package company
  :ensure t
  :custom (add-hook 'after-init-hook 'global-company-mode))

(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-cycle t)
  (setq completion-styles '(hotfuzz flex)))

(use-package savehist
  :ensure t
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators)
  '(marginalia-annotators-heavy
    marginalia-annotators-light
    nil)
  :init
  (marginalia-mode))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(use-package cider
  :ensure t
  :init
  (setq cider-repl-pop-to-buffer-on-connect nil)
  (setq cider-popup-stacktraces nil)
  (setq cider-font-lock-dynamically '(macro core function var))
  (setq cider-show-error-buffer nil)
  (setq cider-save-file-on-load t))

(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
	 ("M-y" . consult-yank-pop))
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init 
  
  (setq register-preview-delay 0.5
	register-preview-function #'consult-register-format)

  (advice-add #'register-preview :override #'consult-register-window)

  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref))

(use-package paredit
  :ensure t 
  :hook ((cider-repl-mode       . paredit-mode)
	 (cider-mode            . paredit-mode)
	 (clojure-mode          . paredit-mode)
	 (emacs-lisp-mode       . paredit-mode)
	 (lisp-mode             . paredit-mode)
	 (lisp-interaction-mode . paredit-mode)
	 (scheme-mode           . paredit-mode)
	 (slime-mode            . paredit-mode)))

(use-package expand-region
  :ensure t
  :bind (("<M-s-up>" . 'er/expand-region)
	 ("<M-s-down>" . 'er/contract-region)))

(use-package lsp-treemacs
  :ensure t)

(use-package flycheck-clj-kondo
  :ensure t)

(use-package js2-mode
  :ensure t)

(use-package clojure-mode
  :ensure t
  :config
  (require 'flycheck-clj-kondo))

(use-package flycheck 
  :ensure t
  :hook ((clojure-mode . flycheck-mode)))

(use-package lsp-mode
  :ensure t
  :hook ((clojure-mode       . lsp)
	 (clojurescript-mode . lsp)
	 (clojurec-mode      . lsp)
	 (js2-mode           . lsp)
	 (python-mode        . lsp))
  :init
  (setq gc-cons-threshold (* 100 1024 1024)
	read-process-output-max (* 1024 1024)
	treemacs-space-between-root-nodes nil
	company-minimum-prefix-length 1
	lsp-lens-enable t))

(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :ensure t
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package vterm
  :ensure t)

(use-package consult-projectile
  :ensure t)

(general-def
  :states  '(normal visual motion)
  :prefix "SPC"
  "SPC" 'consult-projectile-find-file
  "<tab>" 'projectile-switch-project
  "p" 'consult-git-grep
  "f" 'consult-line
  "B" 'consult-line-multi
  "b" 'consult-buffer
  "d" 'evil-goto-definition
  "r" 'lsp-find-references
  "v" 'vterm-other-window
  "y" 'consult-yank-pop
  "o" 'other-window
  "0" 'delete-window
  "1" 'delete-other-windows
  "3" 'split-window-horizontally
  "2" 'split-window-vertically)

(general-def
  :states '(normal visual motion)
  :prefix "SPC s"
  "r" 'paredit-raise-sexp
  "k" 'paredit-kill)

(general-def
  :states '(normal visual motion)
  :prefix "SPC c"
  "e l" 'cider-eval-last-sexp
  "e r" 'cider-eval-region
  "i" 'cider-inspect-last-sexp
  "n" 'cider-repl-set-ns
  "l" 'cider-load-buffer
  "q" 'cider-quit
  "r" 'cider-switch-to-repl-buffer
  "b" 'cider-switch-to-last-clojure-buffer
  "j s" 'cider-jack-in-cljs
  "j c" 'cider-jack-in-clj)

(general-def
  :states '(normal visual motion)
  :prefix "SPC m"
  "s" 'magit-status)

(general-def
  "C-+" 'text-scale-increase
  "C--" 'text-scale-decrease)

(general-def
  "<M-s-right>" 'paredit-forward
  "<M-s-left>" 'paredit-backward)

(use-package windresize
  :ensure t)

(general-def
  :states '(normal visual motion)
  :prefix "SPC w"
  "r" 'windresize)

(use-package slime
  :ensure t
  :config (setq inferior-lisp-program "/usr/bin/sbcl"))

(require 'org-tempo)

(load-theme 'modus-vivendi)
