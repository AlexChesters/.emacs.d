;;; functions.el --- My custom functions -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'projectile)
(require 'pyvenv)

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

(defun atc/find-pyvenv-root (dir)
  "Walk up from DIR looking for a .venv or venv directory."
  (when-let ((root (locate-dominating-file
                    dir
                    (lambda (d)
                      (seq-find #'file-directory-p
                                (mapcar (lambda (name) (expand-file-name name d))
                                        '(".venv" "venv")))))))
    (seq-find #'file-directory-p
              (mapcar (lambda (name) (expand-file-name name root))
                      '(".venv" "venv")))))

(defun atc/projectile-activate-pyvenv ()
  "Activate a pyvenv virtualenv when switching Projectile projects.
Looks for a .venv or venv directory in the project root."
  (when-let* ((root (vc-root-dir))
              (venv-path (seq-find #'file-directory-p
                                   (mapcar (lambda (name)
                                             (expand-file-name name root))
                                           '(".venv" "venv")))))
    (pyvenv-activate venv-path)))

(defun atc/buffer-activate-pyvenv ()
  "Activate a pyvenv virtualenv based on the current buffer's location.
Walks up from the buffer's directory to find the nearest .venv or venv."
  (when (and buffer-file-name
             (derived-mode-p 'python-mode))
    (when-let ((venv-path (atc/find-pyvenv-root (file-name-directory buffer-file-name))))
      (unless (equal (file-truename venv-path)
                     (and pyvenv-virtual-env (file-truename pyvenv-virtual-env)))
        (pyvenv-activate venv-path)))))

(add-hook 'projectile-after-switch-project-hook #'atc/projectile-activate-pyvenv)
(add-hook 'python-mode-hook #'atc/buffer-activate-pyvenv)
(add-hook 'window-configuration-change-hook #'atc/buffer-activate-pyvenv)

(provide 'functions)

;;; functions.el ends here
