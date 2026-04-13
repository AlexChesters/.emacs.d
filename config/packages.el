;;; packages.el --- Configuration for packages -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;;; declare functions/variables from deferred packages to silence byte-compiler

;; variables
(defvar python-mode-map)
(defvar python-ts-mode-map)
(defvar ibuffer-saved-filter-groups)

;; functions
(declare-function ibuffer-switch-to-saved-filter-groups "ibuffer" (name))
(declare-function ibuffer-do-sort-by-alphabetic "ibuffer" () t)

;; ag
(use-package ag
  :ensure t
  :defer t)

;; all the icons
(use-package all-the-icons
  :ensure t
  :defer t)

;; all the icons ibuffer
(use-package all-the-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

;; cfn-mode
(use-package cfn-mode
  :ensure t)
(add-to-list 'magic-mode-alist
  '("\\(.\\|\n\\)*Type: AWS::" . cfn-mode))
;; hack to stop this file from having cfn-mode enabled based on the
;; presence of the cfn-mode magic-mode-alist set up
(add-to-list 'magic-mode-alist
             '("\\(.\\|\n\\)*;;; Commentary" . emacs-lisp-mode))

;; copilot
(use-package copilot
  :ensure t
  :hook (prog-mode . (lambda ()
                       (when (file-exists-p "~/.work-machine")
                         (copilot-mode 1))))
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion))
  :config
  ;; Set mode-specific indentation, plus a default fallback
  (setq copilot-indentation-alist
        '((prog-mode . 2)
          (org-mode . 2)
          (text-mode . 2)
          (closure-mode . 2)
          (emacs-lisp-mode . 2)
          (lisp-interaction-mode . 2)
          (default . 2)))
  ;; Fallback to 2 spaces if no mode-specific indentation is found.
  ;; Suppress the warning it emits before returning nil (e.g. in emacs-lisp-mode).
  (advice-add 'copilot--infer-indentation-offset :around
            (lambda (orig-fn)
              (let ((warning-minimum-level :error))
                (or (funcall orig-fn)
                    2)))))

;; corfu (inline completion popup, works with eglot's CAPF)
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :hook
  (markdown-mode . (lambda () (corfu-mode -1)))
  (gfm-mode      . (lambda () (corfu-mode -1)))
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 2))

;; doom themes
(use-package doom-themes
  :ensure t)

;; drag stuff
(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-mode t))

;; eglot (built-in LSP client)
(use-package eglot
  :hook ((python-mode python-ts-mode) . eglot-ensure)
  :bind (:map python-mode-map
              ("s-r" . eglot-rename)
              :map python-ts-mode-map
              ("s-r" . eglot-rename))
  :config
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio"))))

;; git commit
(use-package git-commit
  :defer t
  :hook (git-commit-mode . (lambda ()
                             (copilot-mode -1)
                             (flycheck-mode -1))))

;; ibuffer
(use-package ibuffer
  :ensure t
  :config
  ;; don't prompt for confirmation dialogs
  (setq ibuffer-expert t)
  ;; group buffers
  (setq ibuffer-saved-filter-groups
        '(("Main"
           ("Python" (or
                      (mode . python-ts-mode)
                      (mode . c-mode)
                      (mode . python-mode)))
           ("Emacs" (or
                     (mode . emacs-lisp-mode)
                     (name . "^\\*Help\\*$")
                     (name . "^\\*Custom.*")
                     (name . "^\\*Org Agenda\\*$")
                     (name . "^\\*info\\*$")
                     (name . "^\\*scratch\\*$")
                     (name . "^\\*Backtrace\\*$")
                     (name . "^\\*Messages\\*$")
                     (name . "^\\*Warnings\\*$")
                     (name . "^\\*copilot")))
          ("Directories" (mode . dired-mode))
          ("Magit" (name . "^magit"))
          ("Fundamental" (or
                          (mode . fundamental-mode)
                          (mode . text-mode))))))
  ;; custom ibuffer setup
  (defun atc/ibuffer-setup ()
    (ibuffer-projectile-set-filter-groups)
    (unless (eq ibuffer-sorting-mode 'alphabetic)
      (ibuffer-do-sort-by-alphabetic)))
  
  :hook
  (ibuffer-mode . atc/ibuffer-setup)
  (ibuffer-update . atc/ibuffer-setup))

;; flycheck
(use-package flycheck
  :ensure t
  :defer t
  :hook
  (prog-mode . flycheck-mode)
  :config
  (flycheck-define-checker cfn-lint
    "A Cloudformation linter using cfn-python-lint."
    :command ("cfn-lint" "-f" "parseable" source)
    :error-patterns
    ((warning line-start
              (file-name) ":" line ":" column
              ":" (one-or-more digit) ":" (one-or-more digit) ":"
              (id "W" (one-or-more digit)) ":" (message) line-end)
     (error line-start (file-name) ":" line ":" column
            ":" (one-or-more digit) ":" (one-or-more digit) ":"
            (id "E" (one-or-more digit)) ":" (message) line-end))
    :modes (cfn-mode))
  (add-to-list 'flycheck-checkers 'cfn-lint))

;; magict
(use-package magit
  :ensure t
  :defer t)

;; marginalia
(use-package marginalia
  :ensure t
  :after (vertico)
  :config
  (marginalia-mode))

;; markdown mode
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

;; neotree
(use-package neotree
  :ensure t
  :defer t
  :bind ("s-F" . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)) ;; set theme, icons if GUI, otherwise arrow
  (setq neo-window-width 40) ;; set neotree width
  (setq neo-show-hidden-files t) ;; show hidden files
  (setq neo-smart-open t) ;; open at current file
  :hook
  (neotree-mode . (lambda ()
                     (display-line-numbers-mode -1))))

;; orderless
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/workspace/" "~/code/"))
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching 'persistent)
  (projectile-mode +1))

;; swiper
(use-package swiper
  :ensure t
  :defer t)

;; vertico
(use-package vertico
  :ensure t
  ;:custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

(use-package vertico-prescient
  :ensure t
  :defer t
  :hook (vertico-mode . vertico-prescient-mode))

;; vterm
(use-package vterm
  :ensure t
  :defer t)
(use-package vterm-toggle
  :ensure t
  :defer t)

(provide 'packages)

;;; packages.el ends here
