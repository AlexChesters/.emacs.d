;;; functions.el - My custom functions

;;; Commentary:

;;; Code:

; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/#tab-key
(defun atc/copilot-complete-or-tab ()
    "Tab command that will complete with copilot if a completion is available, otherwise normal tab-indent."
  (interactive)
  (or (copilot-accept-completion)
      (indent-for-tab-command)))


(provide 'functions)

;;; functions.el ends here
