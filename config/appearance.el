;;; appearance.el --- Custom appearance settings

;;; Commentary:

;;; Code:

;; font size
(set-face-attribute 'default nil :height 150)

;; display line numbers
(global-display-line-numbers-mode)

;; theme
(load-theme 'zenburn t)

;; rulers
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setopt display-fill-column-indicator-column 120)

(provide 'appearance)

;;; appearance.el ends here
