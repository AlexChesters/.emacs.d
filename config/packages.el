;;; packages.el --- Configuration for packages

;;; Commentary:

;;; Code:

;; all-the-icons
(use-package all-the-icons
  :if (display-graphic-p))

;; anaconda-mode
(use-package anaconda-mode)

;; auctex
(use-package auctex)

;; cfn-mode
(use-package cfn-mode
  :config
  (add-to-list 'magic-mode-alist
    '("\\(.\\|\n\\)*Type: AWS::" . cfn-mode))
  ;; hack to stop this file from having cfn-mode enabled based on the
  ;; presence of the cfn-mode magic-mode-alist set up
  (add-to-list 'magic-mode-alist
               '("\\(.\\|\n\\)*;;; Commentary" . emacs-lisp-mode)))

;; company mode
(use-package company
  :hook (after-init . global-company-mode))

;; company-anaconda
(use-package company-anaconda
  :config
  (add-to-list 'company-backends 'company-anaconda))

;; company-box
(use-package company-box
  :hook (company-mode . company-box-mode))

;; copilot
(use-package copilot
  :load-path (lambda () (expand-file-name "packages/copilot.el" user-emacs-directory))
  ;; don't show in mode line
  :diminish
  :config
  (add-hook 'prog-mode-hook 'copilot-mode)
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

;; copilot-chat
(use-package copilot-chat)

;; diff-hl
(use-package diff-hl
  :config
  (global-diff-hl-mode))

;; doom-modeline
(use-package doom-modeline
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-buffer-file-name-style 'truncate-nil))

;; eglot
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("pyls")))
  :hook (python-mode . eglot-ensure))

;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (add-to-list 'flycheck-checkers 'cfn-lint))

(setq python-mode-hook
      (list (defun my-python-hook ()
              (unless (bound-and-true-p org-src-mode)
                (when (buffer-file-name)
                  (setq-local flycheck-checkers '(python-ruff))
                  (flycheck-mode)
                  (anaconda-mode))))))

;; google this
(use-package google-this)

(use-package magit
  :config
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; marginalia
(use-package marginalia
  :config
  (marginalia-mode))

;; move text
(use-package move-text)

;; projectile
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (add-hook 'projectile-after-switch-project-hook 'projectile-update-treemacs)
  (setq projectile-switch-project-action #'projectile-dired))

;; smartparens
(use-package smartparens
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default config
  (require 'smartparens-config))

;; swiper
(use-package swiper)

;; tab line mode
;; function defined here rather than functions.el because that file is loaded after this one (because other functions
;; depend on this file)
;; https://www.reddit.com/r/emacs/comments/1c3oqqh/modern_tabs_in_emacs/
;; https://gist.github.com/satran/95195fc86289dcf05cc8f66c363edb36
(defun atc/set-tab-theme ()
  "Set the theme of tabs."
  (interactive)
  (let ((bg (face-attribute 'mode-line :background))
        (fg (face-attribute 'default :foreground))
        (hg (face-attribute 'default :background))
        (base (face-attribute 'mode-line :background))
        (box-width (/ (line-pixel-height) 4)))
    (set-face-attribute 'tab-line nil
                        :background base
                        :foreground fg
                        :height 0.8
                        :inherit nil
                        :box (list :line-width -1 :color base)
                        )
    (set-face-attribute 'tab-line-tab nil
                        :foreground fg
                        :background bg
                        :weight 'normal
                        :inherit nil
                        :box (list :line-width box-width :color bg))
    (set-face-attribute 'tab-line-tab-inactive nil
                        :foreground fg
                        :background base
                        :weight 'normal
                        :inherit nil
                        :box (list :line-width box-width :color base))
    (set-face-attribute 'tab-line-highlight nil
                        :foreground fg
                        :background hg
                        :weight 'normal
                        :inherit nil
                        :box (list :line-width box-width :color hg))
    (set-face-attribute 'tab-line-tab-current nil
                        :foreground fg
                        :background hg
                        :weight 'normal
                        :inherit nil
                        :box (list :line-width box-width :color hg))))

(use-package tab-line
  :after (doom-modeline)
  :config
  (global-tab-line-mode)
  (setq tab-line-close-button-show nil)
  (setq tab-line-new-button-show nil)
  ;; TODO - figure out why this isn't working
  ;; it looks like a package loading ordering issue, initially the tab bar loads in with incorrect styling
  ;; then if you manually call (atc/set-tab-theme) the theme is applied correctly
  (atc/set-tab-theme))

;; treemacs
(use-package treemacs
  :config
  (setq treemacs-width 50))

;; treemacs-magit
(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;; treemacs-projectile
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

;; vertico
(use-package vertico
  :config
  (vertico-mode))

(provide 'packages)

;;; packages.el ends here
