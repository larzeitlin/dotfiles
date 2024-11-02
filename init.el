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
(setq ring-bell-function 'ignore)
(setq initial-buffer-choice (file-truename "~/dotfiles/emacs-initial-buffer.org"))

(set-face-attribute 'default nil :height 140)
(setq org-confirm-babel-evaluate nil)
(load-theme 'modus-vivendi)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package general
  :ensure t
  :init (general-auto-unbind-keys))

(use-package evil
  :ensure t
  :config (evil-mode 1))

(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "C-r") nil)
  (define-key evil-insert-state-map (kbd "C-r") nil)
  (define-key evil-visual-state-map (kbd "C-r") nil))

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
  vertico-cycle t
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
  (setq cider-repl-pop-to-buffer-on-connect 'display-only)
  (setq cider-popup-stacktraces nil)
  (setq cider-font-lock-dynamically '(macro core function var))
  (setq cider-show-error-buffer nil)
  (setq cider-repl-buffer-size-limit 100000)
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

(use-package evil-cleverparens
  :ensure t 
  :hook ((cider-repl-mode       . evil-cleverparens-mode)
	 (cider-mode            . evil-cleverparens-mode)
	 (clojure-mode          . evil-cleverparens-mode)
	 (emacs-lisp-mode       . evil-cleverparens-mode)
	 (lisp-mode             . evil-cleverparens-mode)
	 (lisp-interaction-mode . evil-cleverparens-mode)
	 (scheme-mode           . evil-cleverparens-mode)
	 (slime-mode            . evil-cleverparens-mode)
	 (slime-repl-mode       . evil-cleverparens-mode)))

(electric-pair-mode 1) ;; default on

(general-def
  :states '(normal visual motion)
  :prefix "SPC s"
  "w r" 'sp-wrap-round
  "w c" 'sp-wrap-curly
  "w s" 'sp-wrap-square
  "r"   'sp-raise-sexp
  "k s" 'sp-kill-sexp)

(general-def
  "<C-right>" 'sp-forward-slurp-sexp
  "<C-left>" 'sp-forward-barf-sexp)

(general-def
  "<M-s-right>" 'sp-forward-sexp
  "<M-s-left>" 'sp-backward-sexp)

(general-def
  :states '(normal visual motion)
  "<M-up>" 'sp-raise-sexp)

(use-package expand-region
  :ensure t
  :bind (("<M-s-up>" . 'er/expand-region)
	 ("<M-s-down>" . 'er/contract-region)))

(use-package flycheck-clj-kondo
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

(general-def
  :states '(normal visual motion)
  :prefix "SPC g"
  "n" 'git-gutter:next-hunk
  "p" 'git-gutter:previous-hunk)

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
  (add-to-list 'python-shell-completion-native-disabled-interpreters
               "jupyter"))

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

(use-package windresize
  :ensure t)

(general-def
  :states '(normal visual motion)
  :prefix "SPC w"
  "r" 'windresize)

(general-def
  :states '(normal visual motion)
  "SPC h d" 'c-hungry-delete)

(general-def
  :states '(normal visual motion)
  :prefix "SPC i"
  "e" (lambda() (interactive)(find-file "~/dotfiles/init.el"))
  "3" (lambda() (interactive)(find-file "~/dotfiles/i3-config"))
  "z" (lambda() (interactive)(find-file "~/.zshrc")))

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(use-package slime
  :ensure t
  :config (setq inferior-lisp-program "/usr/local/bin/sbcl"))

(setf swank:*communication-style* nil)

(require 'org-tempo)

(setq org-src-preserve-indentation nil
      org-edit-src-content-indentation 0)

(use-package simple-httpd
  :ensure t)

(setq org-default-notes-file (concat org-directory "/notes.org"))

(defun copy-current-line-position-to-clipboard ()
  "Copy current line in file to clipboard as '</path/to/file>:<line-number>'."
  (interactive)
  (let ((path-with-line-number
         (concat "[[file:" (buffer-file-name) "::" (number-to-string (line-number-at-pos)) "]]")))
    (kill-new path-with-line-number)
    (message (concat path-with-line-number " copied to clipboard"))))

(setq org-babel-clojure-backend 'cider)

(use-package org-roam
  :ensure t
  :config
  (setq org-roam-directory (file-truename "~/notes"))
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :after org-roam
  :config (setq org-roam-ui-sync-theme t
		org-roam-ui-follow 
		org-roam-ui-update-on-save t
		org-roam-ui-open-on-start t))


