;;; appearance.el --- Custom appearance settings

;;; Commentary:

;;; Code:

;; hide toolbar
(tool-bar-mode -1)

;; font size
(set-face-attribute 'default nil :height 150)

;; display line numbers
(global-display-line-numbers-mode)

;; theme
(load-theme 'material t)

;; rulers
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'markdown-mode-hook #'display-fill-column-indicator-mode)
(setopt display-fill-column-indicator-column 120)

;; prefer splitting windows vertically
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; tab line mode stuff
;; enable tab line mode
(global-tab-line-mode)

;; hide close button
(setq tab-line-close-button-show nil)

;; hide new button
(setq tab-line-new-button-show nil)

(provide 'appearance)

;;; appearance.el ends here
