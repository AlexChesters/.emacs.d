;;; appearance.el --- Custom appearance settings

;;; Commentary:

;;; Code:

;; set font
(set-frame-font "B612 Mono 16")

;; visual line mode
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Visual-Line-Mode.html
;; essentially, stops odd wrapping
(visual-line-mode)

;; hide toolbar
(tool-bar-mode -1)

;; font size
(set-face-attribute 'default nil :height 150)

;; display line numbers
(global-display-line-numbers-mode)

;; theme
(load-theme 'zenburn t)

;; rulers
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'markdown-mode-hook #'display-fill-column-indicator-mode)
(setopt display-fill-column-indicator-column 120)

;; prefer splitting windows vertically
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; force ibuffer to open in the same window
(add-to-list 'display-buffer-alist
  '("^\\*Ibuffer\\*$" . (display-buffer-same-window)))

(provide 'appearance)

;;; appearance.el ends here
