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
(load-file "~/.emacs.d/config/flycheck-checkers.el") ; Loading custom flycheck checkers
(load-file "~/.emacs.d/config/packages.el") ; Loading custom package configuration
(load-file "~/.emacs.d/config/functions.el") ; Loading custom functions
(load-file "~/.emacs.d/config/keys.el") ; Loading key-bindings
(load-file "~/.emacs.d/config/appearance.el") ; Loading custom appearance stuff
(load-file "~/.emacs.d/config/misc.el") ; Loading miscellanous config

;; boot behaviour
(add-hook 'after-init-hook 'atc/projectile-open-emacs-project)

;; prevent the creation of backup files
(setq make-backup-files nil)

;; clean whitespace on every save
(add-hook 'before-save-hook 'whitespace-cleanup)

;; melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(2048-game zenburn-theme github-dark-vscode-theme pyvenv treemacs-magit company-box auctex move-text google-this smartparens marginalia vertico dumb-jump company-anaconda anaconda-mode corfu scratch treemacs-projectile treemacs-all-the-icons treemacs copilot-chat doom-modeline all-the-icons diff-hl cfn-mode swiper f editorconfig s flycheck exec-path-from-shell projectile magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-line ((t (:inherit variable-pitch :background "gray95" :foreground "black" :height 1.0)))))

(provide 'init)

;;; init.el ends here
