;;; functions.el --- My custom functions -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'projectile)

;; https://stackoverflow.com/a/551053
(defun duplicate-line-below ()
  "Duplicate the current line below."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank))

(defun atc/projectile-find-first-file ()
  "Open README.md in the project root if it exists.
If that doesn't exist, open the first project file."
  (interactive)
  (declare-function projectile-project-root "projectile")
  (declare-function projectile-current-project-files "projectile")
  (let* ((project-root (projectile-project-root))
         (readme-file (expand-file-name "README.md" project-root))
         (file (if (file-exists-p readme-file)
                   readme-file
                 (let ((first (car (projectile-current-project-files))))
                   (when first
                     (expand-file-name first project-root))))))
    (when file
      (find-file file))))
(setq projectile-switch-project-action #'atc/projectile-find-first-file)

(provide 'functions)

;;; functions.el ends here
