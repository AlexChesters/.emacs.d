;;; packages.el --- Configuration for packages

;;; Commentary:

;;; Code:

;; all-the-icons
(use-package all-the-icons
  :if (display-graphic-p))

;; anaconda-mode
(use-package anaconda-mode)

;; cfn-mode
(use-package cfn-mode
  :config
  (add-to-list 'magic-mode-alist
    '("\\(.\\|\n\\)*Type: AWS::" . cfn-mode))
  ;; hack to stop this file from having cfn-mode enabled based on the
  ;; presence of the cfn-mode magic-mode-alist set up
  (add-to-list 'magic-mode-alist
	       '("\\(.\\|\n\\)*;;; Commentary" . emacs-lisp-mode)))

;; company mode
(use-package company
  :hook (after-init . global-company-mode))

;; company-anaconda
(use-package company-anaconda
  :config
  (add-to-list 'company-backends 'company-anaconda))

;; copilot
(use-package copilot
  :load-path (lambda () (expand-file-name "packages/copilot.el" user-emacs-directory))
  ;; don't show in mode line
  :diminish
  :config
  ; disable copilot mode for now
  ;(add-hook 'prog-mode-hook 'copilot-mode)
  )

;; copilot-chat
(use-package copilot-chat)

;; diff-hl
(use-package diff-hl
  :config
  (global-diff-hl-mode))

;; doom-modeline
(use-package doom-modeline
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-buffer-file-name-style 'truncate-nil))

;; flycheck
;; https://gist.github.com/AlexChesters/9ec108eab4f50c3ca335e897ddffbbd9
(flycheck-define-checker python-ruff
  "A Python syntax and style checker using the ruff utility.
To override the path to the ruff executable, set
`flycheck-python-ruff-executable'.
See URL `http://pypi.python.org/pypi/ruff'."
  :command ("ruff"
            "check"
            (eval (when buffer-file-name
                    (concat "--stdin-filename=" buffer-file-name)))
            "-")
  :standard-input t
  :error-filter (lambda (errors)
                  (let ((errors (flycheck-sanitize-errors errors)))
                    (seq-map #'flycheck-flake8-fix-error-level errors)))
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" (optional column ":") " "
            (id (one-or-more (any alpha)) (one-or-more digit)) " "
            (message (one-or-more not-newline))
            line-end))
  :modes python-mode)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(setq python-mode-hook
      (list (defun my-python-hook ()
              (unless (bound-and-true-p org-src-mode)
                (when (buffer-file-name)
                  (setq-local flycheck-checkers '(python-ruff))
                  (flycheck-mode)
                  (anaconda-mode))))))

;; helm
(use-package helm)

;; helm-projectile
(use-package helm-projectile
  :config
  (helm-projectile-on))

;; projectile
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (add-hook 'projectile-after-switch-project-hook 'projectile-update-treemacs)
  (setq projectile-switch-project-action #'projectile-dired))

;; swiper
(use-package swiper)

;; treemacs
(use-package treemacs
  :config
  (setq treemacs-width 50))

;; treemacs-projectile
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(provide 'packages)

;;; packages.el ends here
