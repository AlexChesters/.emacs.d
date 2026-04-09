;;; functions.el --- My custom functions

;;; Commentary:

;;; Code:

;; https://stackoverflow.com/a/551053
(defun duplicate-line-below ()
  "Duplicate the current line below."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank))

(provide 'functions)

;;; functions.el ends here
