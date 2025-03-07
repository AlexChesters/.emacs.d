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
Intended to be used as a hook when entering `python-mode'.

Broadly speaking it

1. Tries to find a .venv directory in the current project and activate it.

If one is found:
  a. It calls pyvenv-activate with it
  b. It then checks to see if pylsp is found in the PATH,
which now includes the virtual env
  c. Finally, it calls `eglot-ensure' to start the language server

2. If no .venv directory is found, it tries to find a venv directory.
If one is found it does steps 1a, 1b, and 1c. as above."
  (interactive)
  (if (derived-mode-p 'python-mode)
      (when buffer-file-name
        (let* ((venv-root (locate-dominating-file buffer-file-name ".venv")))
          (if venv-root
              (let ((venv-path (file-name-as-directory (file-name-concat venv-root ".venv"))))
                (message "atc/python-mode-setup activating venv: %s" venv-path)
                (pyvenv-activate venv-path)
                (unless (executable-find "pylsp")
                  (message "pylsp not found in PATH. Installing python-lsp-server.")
                  (with-temp-buffer
                    (shell-command "pip install python-lsp-server" t)))
                (eglot-ensure))
            (message "Error: Could not find a .venv directory for %s. Checking for venv directory." buffer-file-name)
            (let* ((venv-root (locate-dominating-file buffer-file-name "venv")))
              (if venv-root
                  (let ((venv-path (file-name-as-directory (file-name-concat venv-root "venv"))))
                    (message "atc/python-mode-setup activating venv: %s" venv-path)
                    (pyvenv-activate venv-path)
                    (unless (executable-find "pylsp")
                      (message "pylsp not found in PATH. Installing python-lsp-server.")
                      (with-temp-buffer
                        (shell-command "pip install python-lsp-server" t)))
                    (eglot-ensure))
                (message "Error: Could not find a venv directory for %s. Not activating venv." buffer-file-name))))))))
(add-hook 'python-mode-hook 'atc/python-mode-setup)
;; this is needed for cases when you move from one python file to another file
(add-hook 'find-file-hook 'atc/python-mode-setup)
;; this is needed for cases when you move between already open python files
(add-hook 'buffer-list-update-hook 'atc/python-mode-setup)

;; comment or uncomment a region if its active, otherwise the current line
(defun atc/comment-uncomment-region-or-line ()
  "Comment or uncomment highlighted region or line."
  (interactive)
  (if mark-active
    (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))

;; delete a region if its active, otherwise normal backspace behaviour
(defun atc/delete-region-or-backspace ()
  "Delete a region if its active, otherwise normal backspace behaviour."
  (interactive)
  (if mark-active
      (delete-region (region-beginning) (region-end))
    (delete-char -1)))

;; custom neotree function
;; https://www.reddit.com/r/emacs/comments/i4oxdx/neotree_show_file_tree_for_current_buffer/
(declare-function neo-global--window-exists-p nil)
(defun atc/neotree-toggle ()
  "Custom neotree toggle function that ensures it opens at the right location."
  (interactive)
  (if (neo-global--window-exists-p)
    (progn
      (neotree-hide))
    (progn
      (if (buffer-file-name)
        (neotree-dir (file-name-directory (buffer-file-name)))
        (if dired-directory
          (neotree-dir dired-directory)
          (neotree-dir "~/"))))))

(declare-function projectile-project-root nil)
(defun atc/neotree-after-projectile ()
  "Update neotree dir after a projectile switch. Designed to be ran as a hook."
  (neotree-dir (projectile-project-root)))

;; custom function to switch project, integrating projectile and perspective
;; (defvar atc-projects '(foo bar))
;; (defun atc/switch-project ()
;;   "Switch project currently being worked on."
;;   (interactive)
;;   (dol))

;; https://coderwall.com/p/2vnxaw/beautify-json-in-emacs
(defun atc/format-json ()
  "Format a buffer containing JSON."
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
      "python -m json.tool" (current-buffer) t)))

(defun atc/ibuffer ()
  "Custom ibuffer function that prevents a split."
  (interactive)
  (let ((display-buffer-overriding-action '(display-buffer-same-window)))
    (ibuffer)))

;; https://gist.github.com/satran/95195fc86289dcf05cc8f66c363edb36
;; https://www.reddit.com/r/emacs/comments/1c3oqqh/modern_tabs_in_emacs/
(defun atc/set-tab-theme ()
  "Set the theme of tabs."
  (interactive)
  (let ((bg (face-attribute 'mode-line :background))
        (fg (face-attribute 'default :foreground))
        (hg (face-attribute 'default :background))
        (base (face-attribute 'mode-line :background))
        (box-width (/ (line-pixel-height) 4)))
    (set-face-attribute 'tab-line nil
                        :background base
                        :foreground fg
                        :height 0.8
                        :inherit nil
                        :box (list :line-width -1 :color base)
                        )
    (set-face-attribute 'tab-line-tab nil
                        :foreground fg
                        :background bg
                        :weight 'normal
                        :inherit nil
                        :box (list :line-width box-width :color bg))
    (set-face-attribute 'tab-line-tab-inactive nil
                        :foreground fg
                        :background base
                        :weight 'normal
                        :inherit nil
                        :box (list :line-width box-width :color base))
    (set-face-attribute 'tab-line-highlight nil
                        :foreground fg
                        :background hg
                        :weight 'normal
                        :inherit nil
                        :box (list :line-width box-width :color hg))
    (set-face-attribute 'tab-line-tab-current nil
                        :foreground fg
                        :background hg
                        :weight 'normal
                        :inherit nil
                        :box (list :line-width box-width :color hg))))

(provide 'functions)

;;; functions.el ends here
