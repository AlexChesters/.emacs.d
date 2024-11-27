;;; packages.el --- Configuration for packages

;;; Commentary:

;;; Code:

;; company
(use-package company
  :config
  (global-company-mode))

;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; projectile
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

(provide 'packages)

;;; packages.el ends here
