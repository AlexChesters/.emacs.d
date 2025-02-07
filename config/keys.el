;;; keys.el --- Custom keybindings

;;; Commentary:

;;; Code:

;; buffer interaction
(global-set-key (kbd "s-n") 'scratch-buffer) ; Cmd+n - switch to scratch

;; copilot-chat
(define-prefix-command 'copilot-chat-kb-map)
(global-set-key (kbd "C-c c") 'copilot-chat-kb-map)
(define-key 'copilot-chat-kb-map (kbd "c") 'copilot-chat-display) ; C-c c c - copilot-chat display
(define-key 'copilot-chat-kb-map (kbd "r") 'copilot-chat-reset) ; C-c c r - copilot-chat reset
(define-key 'copilot-chat-kb-map (kbd "e") 'copilot-chat-explain) ; C-c c s - copilot-chat explain selected code

;; editing
(global-set-key (kbd "M-<up>") 'duplicate-line-above) ; Alt+up - duplicate line above
(global-set-key (kbd "M-<down>") 'duplicate-line-below) ; Alt+down - duplicate line below
(global-set-key (kbd "s-<up>") 'move-text-up) ; Cmd+up - move text up
(global-set-key (kbd "s-<down>") 'move-text-down) ; Cmd+down - move text down
(global-set-key (kbd "C-c s") 'scratch) ; C-c s - scratch buffer
(global-set-key (kbd "s-/") 'atc/comment-uncomment-region-or-line) ; Cmd+/ - (un)comment region/line
(global-set-key (kbd "<backspace>") 'atc/delete-region-or-backspace) ; backspace - custom backspace function

;; magit
(define-prefix-command 'magit-kb-map)
(global-set-key (kbd "C-c v") 'magit-kb-map)
(define-key 'magit-kb-map (kbd "s") 'magit-status)

;; misc
(global-set-key (kbd "s-w") 'kill-buffer-and-window) ; Cmd+w - kill buffer and its window
(global-set-key (kbd "s-d") 'dired) ; Cmd+d - dired
(global-set-key (kbd "s-<return>") 'eval-buffer) ; Cmd+return - eval buffer
(global-set-key (kbd "s-b") 'atc/ibuffer) ; Cmd+b - ibuffer
(global-set-key (kbd "s-o") 'find-file) ; Cmd+o - find file
(global-set-key (kbd "s-k") 'kill-whole-line) ; Cmd+k - kill whole line
(global-set-key (kbd "s-S-<return>") 'restart-emacs) ; Cmd+Shift+return - restart emacs
(global-set-key (kbd "s-t") 'tetris) ; Cmd+t - tetris

;; navigation
(global-set-key (kbd "M-s-<left>") 'windmove-left) ; Cmd+alt+left, Move left buffer
(global-set-key (kbd "M-s-<right>") 'windmove-right) ; Cmd+alt+right, Move right buffer
(global-set-key (kbd "M-s-<up>") 'windmove-up) ; Cmd+alt+up, Move up buffer
(global-set-key (kbd "M-s-<down>") 'windmove-down) ; Cmd+alt+down, Move down buffer
(global-set-key (kbd "s-<right>") 'next-buffer) ; Cmd+right-arrow, moves to next buffer
(global-set-key (kbd "s-<left>") 'previous-buffer) ; Cmd+left-arrow, moves to previous buffer
(global-set-key (kbd "s-B") 'atc/neotree-toggle) ; Cmd+Shift+b - neotree
(global-set-key (kbd "M-.") 'dumb-jump-go) ; Alt+. - dumb jump go
(global-set-key (kbd "s-g") 'google-this) ; Cmd+g - google this
(global-set-key (kbd "s-l") 'consult-goto-line) ; Cmd+l = consult go to line

;; searching
(global-set-key (kbd "s-f") 'swiper) ; Cmd+f - swiper

(provide 'keys)

;;; keys.el ends here
