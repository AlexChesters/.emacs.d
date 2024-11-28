;; use-package
(eval-when-compile
  (require 'use-package))

;; start full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; disable startup message
(setq inhibit-startup-message t)

;; config files
(load-file "~/.emacs.d/config/packages.el") ; Loading custom package configuration
(load-file "~/.emacs.d/config/functions.el") ; Loading custom functions
(load-file "~/.emacs.d/config/keys.el") ; Loading key-bindings
(load-file "~/.emacs.d/config/appearance.el") ; Loading custom appearance stuff
(load-file "~/.emacs.d/config/misc.el") ; Loading miscellanous config

;; melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(zenburn-theme f editorconfig s flycheck exec-path-from-shell projectile magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
