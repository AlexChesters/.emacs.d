;;; packages.el - Configuration for packages

;; company
(use-package company
  :config
  (global-company-mode))

;; projectile
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))
