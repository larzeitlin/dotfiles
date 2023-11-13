(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode)
(global-display-line-numbers-mode t)
(global-visual-line-mode t)
(package-initialize)
(show-paren-mode)
(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq inhibit-startup-screen t)

(use-package timu-spacegrey-theme
  :ensure t
  :config
  (load-theme 'timu-spacegrey t))

(use-package general
  :ensure t
  :init (general-auto-unbind-keys))

(use-package evil
  :ensure t
  :config (evil-mode 1))

(use-package magit
  :ensure t
  :init (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode . rainbow-delimiters-mode)
	 (slime-repl-mode . rainbow-delimiters-mode)))

(use-package company
  :ensure t
  :custom (add-hook 'after-init-hook 'global-company-mode))

(use-package savehist
  :ensure t
  :init
  (savehist-mode))

(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-cycle t)
  (setq completion-styles '(hotfuzz flex)))

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

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
	 (slime-mode            . paredit-mode)
	 (slime-repl-mode       . paredit-mode)))

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

(use-package rust-mode
  :ensure t
  :config (setq rust-format-on-save t))

(use-package flycheck 
  :ensure t
  :hook ((clojure-mode . flycheck-mode)))

(use-package lsp-mode
  :ensure t
  :hook ((clojure-mode       . lsp)
	 (clojurescript-mode . lsp)
	 (clojurec-mode      . lsp)
	 (js2-mode           . lsp)
	 (python-mode        . lsp)
	 (rust-mode-hook     . lsp))
  :init
  (setq gc-cons-threshold (* 100 1024 1024)
	read-process-output-max (* 1024 1024)
	treemacs-space-between-root-nodes nil
	company-minimum-prefix-length 1
	lsp-lens-enable t
	lsp-headerline-breadcrumb-enable nil)) 

(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :ensure t
  :init (setq-default left-fringe-width 20)
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package vterm
  :ensure t
  :config)

(use-package multi-vterm :ensure t)

(use-package consult-projectile
  :ensure t)

(general-def
  :states '(normal)
  :keymaps 'vterm-mode-map
  "p" 'vterm-yank
  "P" 'vterm-yank)

(general-def
  :states  '(normal visual motion)
  :prefix "SPC"
  "SPC" 'consult-projectile-find-file
  "<tab>" 'projectile-switch-project
  "j" 'dired-jump
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
  "2" 'split-window-vertically
  "5" 'make-frame-command
  )

(general-def
  :states '(normal visual motion)
  :prefix "SPC s"
  "r" 'paredit-raise-sexp
  "k" 'paredit-kill
  "b" 'paredit-backward
  "f" 'paredit-forward)

(general-def
  :states '(normal visual motion)
  "<M-up>" 'paredit-raise-sexp)

(general-def
  :states '(normal visual motion)
  :prefix "SPC c"
  "e l" 'cider-eval-last-sexp
  "e s" 'cider-eval-dwim
  "e r" 'cider-eval-last-sexp-to-repl  
  "i" 'cider-inspect-last-sexp
  "n" 'cider-repl-set-ns
  "d" 'cider-doc
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

(general-def
  :states '(normal visual motion)
  :prefix "SPC i"
  "e" (lambda() (interactive)(find-file "~/dotfiles/init.el"))
  "3" (lambda() (interactive)(find-file "~/dotfiles/i3-config"))
  "z" (lambda() (interactive)(find-file "~/.zshrc")))

(use-package slime
  :ensure t
  :config (setq inferior-lisp-program "/usr/bin/sbcl"))

(require 'org-tempo)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package simple-httpd
  :ensure t)

(use-package flymake-python-pyflakes
  :ensure t
  :hook ((python-mode-hook . flymake-python-pyflakes-load)))

(setq org-default-notes-file (concat org-directory "/notes.org"))

(use-package chatgpt-shell
  :ensure t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a9abd706a4183711ffcca0d6da3808ec0f59be0e8336868669dc3b10381afb6f" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "1cae4424345f7fe5225724301ef1a793e610ae5a4e23c023076dc334a9eb940a" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "bf948e3f55a8cd1f420373410911d0a50be5a04a8886cabe8d8e471ad8fdba8e" "e1f4f0158cd5a01a9d96f1f7cdcca8d6724d7d33267623cc433fe1c196848554" "4fda8201465755b403a33e385cf0f75eeec31ca8893199266a6aeccb4adedfa4" "9d29a302302cce971d988eb51bd17c1d2be6cd68305710446f658958c0640f68" "680f62b751481cc5b5b44aeab824e5683cf13792c006aeba1c25ce2d89826426" "251ed7ecd97af314cd77b07359a09da12dcd97be35e3ab761d4a92d8d8cf9a71" "51c71bb27bdab69b505d9bf71c99864051b37ac3de531d91fdad1598ad247138" "ae426fc51c58ade49774264c17e666ea7f681d8cae62570630539be3d06fd964" "991ca4dbb23cab4f45c1463c187ac80de9e6a718edc8640003892a2523cb6259" "7e068da4ba88162324d9773ec066d93c447c76e9f4ae711ddd0c5d3863489c52" default))
 '(elfeed-feeds
   '("http://feeds.bbci.co.uk/news/world/rss.xml#" "https://hnrss.org/frontpage" "http://feeds.bbci.co.uk/news/world/rss.xml"))
 '(ispell-dictionary nil)
 '(lisp-mode-hook '(paredit-mode sly-editing-mode))
 '(markdown-command "pandoc")
 '(package-selected-packages
   '(orderless org-babel chatgpt-shell chatgpt slack timu-spacegrey-theme ox-reveal all-the-icons-gnus clj-refactor elfeed typescript-mode fira-code-mode rust-mode htmlize lsp-jedi flymake-python-pyflakes zenburn-theme ox-publish all-the-icons multi-vterm cmake-mode windresize which-key vterm vertico use-package rainbow-delimiters paredit marginalia magit lsp-treemacs js2-mode git-gutter-fringe general flycheck-clj-kondo expand-region evil consult-projectile company cider auto-package-update))
 '(safe-local-variable-values '((cider-repl-display-help-banner))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#2b303b" :foreground "#c0c5ce" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :family "Ubuntu Mono" :height 160))))
 '(flycheck-error ((t (:background "#3a3d4b" :underline nil))))
 '(flycheck-warning ((t (:background "SlateBlue4" :underline nil)))))

