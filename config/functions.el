;;; functions.el - My custom functions

;;; Commentary:

;;; Code:

; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/#copilot-specific
(defun atc/copilot-complete-or-accept ()
  "Command that either triggers a completion or accepts one if one is available."
  (interactive)
  (if (copilot--overlay-visible)
      (progn
        (copilot-accept-completion)
        (open-line 1)
        (next-line))
    (copilot-complete)))

(provide 'functions)

;;; functions.el ends here
