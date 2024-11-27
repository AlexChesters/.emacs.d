;;; keys.el --- Custom keybindings

;; misc
(global-set-key (kbd "s-w") 'kill-buffer-and-window) ; Cmd+w - close buffer and window
(global-set-key (kbd "s-d") 'dired) ; Cmd+d - dired

;; magit
(define-prefix-command 'magit-kb-map)
(global-set-key (kbd "C-c v") 'magit-kb-map)
(define-key 'magit-kb-map (kbd "s") 'magit-status)
