;;; flycheck-checkers.el --- Custom flycheck checkers

;;; Commentary:

;;; Code:

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
