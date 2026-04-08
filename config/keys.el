;;; keys.el --- Custom keybindings

;;; Commentary:

;;; Code:

;; magit
(define-prefix-command 'magit-kb-map)
(global-set-key (kbd "C-c v") 'magit-kb-map)
(define-key 'magit-kb-map (kbd "s") 'magit-status)

;; misc
(global-set-key (kbd "s-w") 'kill-buffer-and-window) ; Cmd+w - kill buffer and its window

;; navigation
(global-set-key (kbd "M-s-<left>") 'windmove-left) ; Cmd+alt+left, Move left buffer
(global-set-key (kbd "M-s-<right>") 'windmove-right) ; Cmd+alt+right, Move right buffer
(global-set-key (kbd "M-s-<up>") 'windmove-up) ; Cmd+alt+up, Move up buffer
(global-set-key (kbd "M-s-<down>") 'windmove-down) ; Cmd+alt+down, Move down buffer

(provide 'keys)

;;; keys.el ends here
