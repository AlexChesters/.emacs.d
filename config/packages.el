;;; packages.el --- Configuration for packages

;;; Commentary:

;;; Code:

;; all-the-icons
(use-package all-the-icons
  :if (display-graphic-p))

;; anaconda-mode
(use-package anaconda-mode
  :defer t)

;; auctex
(use-package auctex
  :defer t)

;; cfn-mode
(use-package cfn-mode
  :hook (cfn-mode . flycheck-mode))
(add-to-list 'magic-mode-alist
  '("\\(.\\|\n\\)*Type: AWS::" . cfn-mode))
;; hack to stop this file from having cfn-mode enabled based on the
;; presence of the cfn-mode magic-mode-alist set up
(add-to-list 'magic-mode-alist
  '("\\(.\\|\n\\)*;;; Commentary" . emacs-lisp-mode))

;; company mode
(use-package company
  :defer t
  :hook (after-init . global-company-mode)
  :config
  (setq company-dabbrev-downcase nil))

;; company-anaconda
(use-package company-anaconda
  :defer t
  :config
  (add-to-list 'company-backends 'company-anaconda))

;; company-box
(use-package company-box
  :defer t
  :hook (company-mode . company-box-mode))

;; consult
(use-package consult
  :init
  :hook (completion-list-mode . consult-preview-at-point-mode))

;; copilot
(use-package copilot
  :defer t
  :load-path (lambda () (expand-file-name "packages/copilot.el" user-emacs-directory))
  ;; don't show in mode line
  :diminish
  :config
  ;; copilot mode is getting in the way of other completes so turning it off for now
  ;;(add-hook 'prog-mode-hook 'copilot-mode)
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))
  :bind
  (:map copilot-mode-map
        ("<tab>" . atc/copilot-complete-or-tab)))

;; copilot-chat
(use-package copilot-chat
  :defer t)

;; css mode
(use-package css-mode
  :defer t
  :custom
  (css-indent-offset 2))

;; diff-hl
(use-package diff-hl
  :defer t
  :hook
  (prog-mode . diff-hl-mode)
  (magit-mode . diff-hl-mode))

;; doom-modeline
(use-package doom-modeline
  :defer t
  :init (doom-modeline-mode 1)
  ;; filename style
  (setq doom-modeline-buffer-file-name-style 'truncate-nil)

  ;; progress (e.g. line numbers, % through file)
  (setq doom-modeline-position-line-format nil)
  (setq doom-modeline-percent-position nil)

  ;; encoding
  (setq doom-modeline-buffer-encoding nil))

;; eglot
(use-package eglot
  :defer
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("pylsp")))
  :hook (python-mode . eglot-ensure)
  :bind (:map python-mode-map
              ("s-r" . eglot-rename)))

;; flycheck
(use-package flycheck
  :defer
  :hook
  (prog-mode . flycheck-mode)
  :config
  (add-to-list 'flycheck-checkers 'cfn-lint))

(setq python-mode-hook
      (list (defun my-python-hook ()
              (unless (bound-and-true-p org-src-mode)
                (when (buffer-file-name)
                  (setq-local flycheck-checkers '(python-ruff))
                  (flycheck-mode)
                  (anaconda-mode))))))

;; github-pull-requests
(use-package github-pull-requests
  :load-path "~/code/github-pull-requests.el/lisp")

;; google this
(use-package google-this
  :defer t)

;; hcl-mode
(use-package hcl-mode
  :defer t
  :config
  (setq hcl-indent-level 2))

;; ibuffer
(use-package ibuffer
  :config
  ;; don't prompt for confirmation dialogs
  (setq ibuffer-expert t))

;; js mode
(use-package js-mode
  :defer t
  :custom
  (js-indent-level 2))

;; livedown
(use-package livedown
  :load-path (lambda () (expand-file-name "packages/emacs-livedown" user-emacs-directory)))

;; magit
(use-package magit
  :defer t
  :config
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1))

;; marginalia
(use-package marginalia
  :after (vertico)
  :config
  (marginalia-mode))

;; move text
(use-package move-text
  :defer t)

(use-package neotree
  :config
  (setq neo-show-hidden-files t))

;; projectile
(use-package projectile
  :init (projectile-mode +1)
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (setq projectile-switch-project-action #'magit-status)
  (add-hook 'projectile-after-switch-project-hook #'atc/neotree-after-projectile))

;; smartparens
(use-package smartparens
  :defer t
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default config
  (require 'smartparens-config))

;; systemd
(use-package systemd
  :defer t
  :mode ("\\.service\\'" . systemd-mode))

;; swiper
(use-package swiper
  :defer t)

;; tab line mode
(use-package tab-line
  :after (doom-modeline)
  :config
  (global-tab-line-mode)
  (setq tab-line-close-button-show nil)
  (setq tab-line-new-button-show nil))

;; terraform mode
(use-package terraform-mode
  :defer t
  :mode ("\\.tf\\'" . terraform-mode))

;; typescript mode
(use-package typescript-mode
  :defer t
  :mode
  (("\\.ts\\'" . typescript-mode)))

;; web mode
(use-package web-mode
  :mode
  (("\\.html\\'" . web-mode))
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

;; vertico
(use-package vertico
  :config
  (vertico-mode))

(provide 'packages)

;;; packages.el ends here
