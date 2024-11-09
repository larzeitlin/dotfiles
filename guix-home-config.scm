(define-module (guix-home-config)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu services)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages gnuzilla)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages tmux)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages java)
  #:use-module (gnu packages readline)
  #:use-module (guix gexp))

(define bashrc-include
  "eval \"$(fzf --bash)\"
export PATH=\"/usr/local/bin:$PATH\"")

(define bash-aliases
  '(("ghr" . "guix home reconfigure ~/dotfiles/guix-home-config.scm")))

(define home-config
  (home-environment
   (packages
    (list git htop ripgrep fzf nyxt gcc tmux curl emacs-vterm
	  nyxt openjdk rlwrap icecat))
   (services
    (list
     (service home-bash-service-type
	      (home-bash-configuration
	       (guix-defaults? #t)
	       (aliases bash-aliases)
	       (bashrc
		(list
		 (plain-file "bashrc-include"
			     bashrc-include)))))
     (service home-files-service-type
	      `((".guile" ,%default-dotguile)
		(".Xdefaults" ,%default-xdefaults)))
     
     (service home-xdg-configuration-files-service-type
	      `(("gdb/gdbinit" ,%default-gdbinit)
		("nano/nanorc" ,%default-nanorc)))))))

home-config
