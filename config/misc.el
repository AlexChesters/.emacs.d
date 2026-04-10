;;; misc.el --- Miscellanous config

;;; Commentary:

;;; Code:

;; set default directory to emacs config directory
(setq default-directory "~/.emacs.d")

;; https://stackoverflow.com/questions/2627289/how-to-replace-a-region-in-emacs-with-yank-buffer-contents
(delete-selection-mode 1)

;; spaces > tabs
(setq-default indent-tabs-mode nil)

;; it's not the 70s anymore, we don't need two spaces after a period
(setq sentence-end-double-space nil)

;; case-insensitive completion
(setq completion-ignore-case t)

;; electric pair mode
(electric-pair-mode)

;; put backup files in a central trash store
(setq backup-directory-alist
      '((".*" . "~/.emacs-trash")))

;; nodejs
(add-to-list 'exec-path "/Users/alex/.nvm/versions/node/v24.14.1/bin")
(setenv "PATH" (concat "/Users/alex/.nvm/versions/node/v24.14.1/bin:" (getenv "PATH")))

(provide 'misc)

;;; misc.el ends here
