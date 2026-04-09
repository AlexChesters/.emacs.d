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

;; copilot
(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion))
  :config
  ;; Set mode-specific indentation, plus a default fallback
  (setq copilot-indentation-alist
        '((prog-mode . 2)
          (org-mode . 2)
          (text-mode . 2)
          (closure-mode . 2)
          (emacs-lisp-mode . 2)
          (lisp-interaction-mode . 2)
          (default . 2)))
  ;; Fallback to 2 spaces if no mode-specific indentation is found
  (advice-add 'copilot--infer-indentation-offset :around
            (lambda (orig-fn)
              (or (funcall orig-fn)
                  2))))


;; drag stuff
(use-package drag-stuff
  :config
  (drag-stuff-mode t))

;; git commit
(use-package git-commit
  :defer t
  :hook (git-commit-mode . (lambda ()
                             (copilot-mode -1)
                             (flycheck-mode -1))))

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

;; magict
(use-package magit
  :defer t)

;; marginalia
(use-package marginalia
  :after (vertico)
  :config
  (marginalia-mode))

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
  (setq neo-show-hidden-files t) ;; show hidden files
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
