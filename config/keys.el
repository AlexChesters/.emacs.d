;;; keys.el --- Custom keybindings

;;; Commentary:

;;; Code:

;; copilot
(define-key copilot-mode-map (kbd "<tab>") 'atc/copilot-complete-or-tab) ; Cmd+tab - custom copilot completion function

;; editing
(global-set-key (kbd "M-<down>") 'duplicate-line) ; Alt+down - duplicate line

;; misc
(global-set-key (kbd "s-w") 'kill-buffer-and-window) ; Cmd+w - close buffer and window
(global-set-key (kbd "s-d") 'dired) ; Cmd+d - dired
(global-set-key (kbd "s-<return>") 'eval-buffer) ; Cmd+return - eval buffer
(global-set-key (kbd "s-b") 'ibuffer) ; Cmd+b - ibuffer
(global-set-key (kbd "s-o") 'find-file) ; Cmd+o - find file
(global-set-key (kbd "s-k") 'kill-whole-line) ; Cmd+k - kill whole line

;; magit
(define-prefix-command 'magit-kb-map)
(global-set-key (kbd "C-c v") 'magit-kb-map)
(define-key 'magit-kb-map (kbd "s") 'magit-status)

;; navigation
(global-set-key (kbd "M-s-<left>") 'windmove-left) ; Cmd+alt+left, Move left buffer
(global-set-key (kbd "M-s-<right>") 'windmove-right) ; Cmd+alt+right, Move right buffer
(global-set-key (kbd "M-s-<up>") 'windmove-up) ; Cmd+alt+up, Move up buffer
(global-set-key (kbd "M-s-<down>") 'windmove-down) ; Cmd+alt+down, Move down buffer
(global-set-key (kbd "s-<right>") 'next-buffer) ; Cmd+right-arrow, moves to next buffer
(global-set-key (kbd "s-<left>") 'previous-buffer) ; Cmd+left-arrow, moves to previous buffer

;; searching
(global-set-key (kbd "s-f") 'swiper) ; Cmd+f - swiper

(provide 'keys)

;;; keys.el ends here
