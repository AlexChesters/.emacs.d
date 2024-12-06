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

;; https://www.emacswiki.org/emacs/KillingBuffers#h5o-2
(defun atc/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;; https://www.emacswiki.org/emacs/KillingBuffers#h5o-5
(defun atc/close-and-kill-this-pane ()
  "If there are multiple windows, then close this pane and kill the buffer in it also."
  (interactive)
  (kill-this-buffer)
  (if (not (one-window-p))
      (delete-window)))

;; set up python stuff properly
(defun atc/python-mode-setup ()
  "Set up appropriate stuff in `python-mode'.
Intended to be used as a hook when entering `python-mode'."
  (interactive)
  (when buffer-file-name
    (let* ((venv-root (locate-dominating-file buffer-file-name ".venv")))
      (if venv-root
          (let ((venv-path (file-name-as-directory (file-name-concat venv-root ".venv"))))
            (message "atc/python-mode-setup activating venv: %s" venv-path)
            (pyvenv-activate venv-path)
            (eglot-ensure))
        (message "Error: Could not find a .venv directory for %s. Checking for venv directory." buffer-file-name)
        (let* ((venv-root (locate-dominating-file buffer-file-name "venv")))
          (if venv-root
              (let ((venv-path (file-name-as-directory (file-name-concat venv-root "venv"))))
                (message "atc/python-mode-setup activating venv: %s" venv-path)
                (pyvenv-activate venv-path)
                (eglot-ensure))
            (message "Error: Could not find a venv directory for %s. Not activating venv." buffer-file-name)))
        ))))
(add-hook 'python-mode-hook 'atc/python-mode-setup)

(provide 'functions)

;;; functions.el ends here
