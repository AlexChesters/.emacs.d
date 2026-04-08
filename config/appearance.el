;;; appearance.el --- Custom appearance settings

;;; Commentary:

;;; Code:

;; hide toolbar
(tool-bar-mode -1)

;; font size
(set-face-attribute 'default nil :height 150)

;; display line numbers
(global-display-line-numbers-mode)

;; mode line
(setq projectile-mode-line-prefix " Proj")
(setq projectile-mode-line-function
      (lambda () (format " [Project - %s]" (projectile-project-name))))
(setq-default mode-line-format
              '(" %* "
                (:eval (if (bound-and-true-p projectile-mode)
                           projectile--mode-line
                         ""))
                " | %f %l:%C %*"))

;; Theme
(load-theme 'sanityinc-tomorrow-night t)

(provide 'appearance)

;;; appearance.el ends here
