;;; packages.el --- Configuration for packages -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(provide 'packages)

;; ag
(use-package ag
  :defer t)

;; cfn-mode
(use-package cfn-mode)
(add-to-list 'magic-mode-alist
  '("\\(.\\|\n\\)*Type: AWS::" . cfn-mode))
;; hack to stop this file from having cfn-mode enabled based on the
;; presence of the cfn-mode magic-mode-alist set up
(add-to-list 'magic-mode-alist
             '("\\(.\\|\n\\)*;;; Commentary" . emacs-lisp-mode))

;; drag stuff
(use-package drag-stuff
  :config
  (drag-stuff-mode t))

;; git commit
(use-package git-commit
  :defer t
  :hook (git-commit-mode . (lambda () (flycheck-mode -1))))

;; ibuffer
(use-package ibuffer
  :config
  ;; don't prompt for confirmation dialogs
  (setq ibuffer-expert t))

;; flycheck
(use-package flycheck
  :defer
  :hook
  (prog-mode . flycheck-mode))

;; magic
(use-package magit
  :defer t)

;; markdown mode
(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

;; neotree
(use-package neotree
  :defer t
  :bind ("s-f" . neotree-toggle)
  :config
  (setq neo-smart-open t)) ;; open at current file

;; orderless
(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; projectile
(use-package projectile
  :init
  (setq projectile-project-search-path '("~/workspace/" "~/code/"))
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (setq projectile-indexing-method 'alien)
  (projectile-mode +1))

;; vertico
(use-package vertico
  ;:custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

(use-package vertico-prescient
  :defer t
  :hook (vertico-mode . vertico-prescient-mode))

;;; packages.el ends here
