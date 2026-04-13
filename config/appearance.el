;;; appearance.el --- Custom appearance settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'projectile)

;; hide toolbar
(tool-bar-mode -1)

;; hide scrollbar
(scroll-bar-mode -1)

;; enable tracking of recent files
(recentf-mode 1)

;; revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

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
                " | %f %l:%C"
                (:eval (let ((time-str (format-time-string " %a %d %b %H:%M ")))
                          (concat
                           (propertize " "
                                       'display `((space :align-to (- right ,(string-width time-str)))))
                           time-str)))))

;; theme
(load-theme 'doom-vibrant t)

(provide 'appearance)

;;; appearance.el ends here
