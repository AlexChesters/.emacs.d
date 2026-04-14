;;; packages-dev.el --- Configuration for bleeding-edge, custom packages -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; jsonl-mode
(use-package jsonl-mode
  :defer t
  :load-path "~/code/jsonl-mode.el"
  :mode ("\\.jsonl\\'"))

(provide 'packages-dev)

;;; packages-dev.el ends here
