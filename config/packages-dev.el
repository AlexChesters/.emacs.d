;;; packages-dev.el --- Configuration for bleeding-edge, custom packages -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; github-pull-requests
(use-package github-pull-requests
  :load-path "~/code/github-pull-requests.el")

;; jsonl-mode
(use-package jsonl-mode
  :defer t
  :load-path "~/code/jsonl-mode.el"
  :mode ("\\.jsonl\\'"))

(provide 'packages-dev)

;;; packages-dev.el ends here
