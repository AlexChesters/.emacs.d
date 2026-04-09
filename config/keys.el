;;; keys.el --- Custom keybindings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; editing
(global-set-key (kbd "M-<down>") 'duplicate-line-below) ; Alt+shift+down, Duplicate line below
(global-set-key (kbd "s-<up>") 'drag-stuff-up) ; Cmd+up, Move stuff up
(global-set-key (kbd "s-<down>") 'drag-stuff-down) ; Cmd+down, Move stuff down

;; exploration
(global-set-key (kbd "s-G") 'ag) ; Cmd+G, Search using ag
(global-set-key (kbd "s-S") 'swiper) ; Cmd+S, Search using swiper

;; magit
(define-prefix-command 'magit-kb-map)
(global-set-key (kbd "C-c v") 'magit-kb-map)
(define-key 'magit-kb-map (kbd "s") 'magit-status)

;; misc
(global-set-key (kbd "s-W") 'kill-buffer-and-window) ; Cmd+w - kill buffer and its window

;; navigation
(global-set-key (kbd "M-s-<left>") 'windmove-left) ; Cmd+alt+left, Move left buffer
(global-set-key (kbd "M-s-<right>") 'windmove-right) ; Cmd+alt+right, Move right buffer
(global-set-key (kbd "M-s-<up>") 'windmove-up) ; Cmd+alt+up, Move up buffer
(global-set-key (kbd "M-s-<down>") 'windmove-down) ; Cmd+alt+down, Move down buffer
(global-set-key (kbd "s-<left>") 'tab-previous) ; Cmd+left, Previous tab
(global-set-key (kbd "s-<right>") 'tab-next) ; Cmd+right, Right tab
(global-set-key (kbd "s-t") 'tab-new) ; Cmd+t, New tab
(global-set-key (kbd "s-w") 'tab-close) ; Cmd+w, Close tab
(global-set-key (kbd "s-b") 'ibuffer) ; Cmd+b, ibuffer

(provide 'keys)

;;; keys.el ends here
