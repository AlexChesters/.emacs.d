;;; misc.el --- Miscellanous config -*- lexical-binding: t; -*-

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

;; don't ask for confirmation when killing buffers
(setq kill-buffer-query-functions nil)

;; y/n instead of yes/no
(setopt use-short-answers t)

;; nodejs
(add-to-list 'exec-path "/Users/alex/.nvm/versions/node/v24.14.1/bin")
(setenv "PATH" (concat "/Users/alex/.nvm/versions/node/v24.14.1/bin:" (getenv "PATH")))

;; empty scratch buffer
(setq initial-scratch-message ";;; -*- lexical-binding: t; -*-\n\n")

;; disable bidirectional text support for better performance
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; skip fontification during input
(setq redisplay-skip-fontification-on-input t)

;; increase process output buffer for lsp
(setq read-process-output-max (* 4 1024 1024)) ; 4MB

(provide 'misc)

;;; misc.el ends here
