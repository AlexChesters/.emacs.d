;;; flycheck-checkers.el --- Custom flycheck checkers

;;; Commentary:

;;; Code:

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

;; https://awk.space/blog/cfn-lint/
 (flycheck-define-checker cfn-lint
   "A Cloudformation linter using cfn-python-lint."
   :command ("cfn-lint" "-f" "parseable" source)
   :error-patterns
   (
    (warning line-start
             (file-name) ":" line ":" column
             ":" (one-or-more digit) ":" (one-or-more digit) ":"
             (id "W" (one-or-more digit)) ":" (message) line-end)
    (error line-start (file-name) ":" line ":" column
           ":" (one-or-more digit) ":" (one-or-more digit) ":"
           (id "E" (one-or-more digit)) ":" (message) line-end)
    )
   :modes (cfn-mode))

(provide 'flycheck-checkers)

;;; flycheck-checkers.el ends here
