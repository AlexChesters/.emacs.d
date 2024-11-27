;;; keys.el --- Custom keybindings

;; misc
(global-set-key (kbd "s-w") 'kill-buffer-and-window) ; Cmd+w - close buffer and window
(global-set-key (kbd "s-d") 'dired) ; Cmd+d - dired
(global-set-key (kbd "s-<return>") 'eval-buffer) ; Cmd+return - eval buffer
(global-set-key (kbd "s-b") 'ibuffer) ; Cmd+b - ibuffer
(global-set-key (kbd "s-o") 'find-file) ; Cmd+o - find file

;; magit
(define-prefix-command 'magit-kb-map)
(global-set-key (kbd "C-c v") 'magit-kb-map)
(define-key 'magit-kb-map (kbd "s") 'magit-status)

;; navigation
(global-set-key (kbd "s-<left>") 'windmove-left) ; Cmd+left, Move left buffer
(global-set-key (kbd "s-<right>") 'windmove-right) ; Cmd+right, Move right buffer
(global-set-key (kbd "s-<up>") 'windmove-up) ; Cmd++up, Move up buffer
(global-set-key (kbd "s-<down>") 'windmove-down) ; Cmd++down, Move down buffer
(global-set-key (kbd "M-s-<right>") 'next-buffer) ; Cmd+lt+right-arrow, moves to next buffer
(global-set-key (kbd "M-s-<left>") 'previous-buffer) ; Cmd+alt+left-arrow, moves to previous buffer
