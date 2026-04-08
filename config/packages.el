;;; packages.el --- Configuration for packages

;;; Commentary:

;;; Code:

(provide 'packages)

;; cfn-mode
(use-package cfn-mode)
(add-to-list 'magic-mode-alist
  '("\\(.\\|\n\\)*Type: AWS::" . cfn-mode))
;; hack to stop this file from having cfn-mode enabled based on the
;; presence of the cfn-mode magic-mode-alist set up
(add-to-list 'magic-mode-alist
  '("\\(.\\|\n\\)*;;; Commentary" . emacs-lisp-mode))

;; markdown mode
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

;; orderless
(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; TODO - FIND FILE IS SLOW
;; projectile
(use-package projectile
  :ensure t
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
