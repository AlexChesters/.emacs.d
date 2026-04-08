;;; init.el --- Emacs entry point

;;; Commentary:

;; various start up steps in here are from https://blog.d46.us/advanced-emacs-startup/

;;; Code:

;; Make startup faster by reducing the frequency of garbage
;; collection.  The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; use-package
(eval-when-compile
  (require 'use-package))

;; start full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; disable startup message
(setq inhibit-startup-message t)

;; config files
(load-file "~/.emacs.d/config/packages.el") ; Loading custom package configuration
(load-file "~/.emacs.d/config/keys.el") ; Loading key-bindings
(load-file "~/.emacs.d/config/appearance.el") ; Loading custom appearance stuff
(load-file "~/.emacs.d/config/misc.el") ; Loading miscellanous config

;; melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6fc9e40b4375d9d8d0d9521505849ab4d04220ed470db0b78b700230da0a86c1"
     default))
 '(package-selected-packages
   '(cfn-mode color-theme-sanityinc-tomorrow magit markdown-mode
              orderless projectile vertico vertico-prescient)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
