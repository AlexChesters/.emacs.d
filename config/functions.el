;;; functions.el --- My custom functions

;;; Commentary:

;;; Code:

;; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/#tab-key
(declare-function copilot-accept-completion "nil" ())
(defun atc/copilot-complete-or-tab ()
  "Tab command that will complete with copilot if a completion is available, otherwise normal tab-indent."
  (interactive)
  (or (copilot-accept-completion)
      (indent-for-tab-command)))

;; https://stackoverflow.com/a/551053
(defun duplicate-line-below ()
  "Duplicate the current line below."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank))

;; TODO - fix this function
(defun duplicate-line-above ()
  "Duplicate the current line above."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (forward-line -1)
  (yank))

(declare-function treemacs-display-current-project-exclusively "nil" ())
(defun projectile-update-treemacs ()
  "Update treemacs upon projectile project change but without updating focus (https://github.com/Alexander-Miller/treemacs/issues/1072)."
  (save-selected-window
    (treemacs-display-current-project-exclusively)))

(declare-function projectile-switch-project-by-name "nil" ("project-dir"))
(defun atc/projectile-open-emacs-project ()
  "Open the Emacs project in projectile."
  (projectile-switch-project-by-name "~/.emacs.d"))

(provide 'functions)

;;; functions.el ends here
