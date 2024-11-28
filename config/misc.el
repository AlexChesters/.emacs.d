;;; misc.el - Miscellanous config

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/DEL-Does-Not-Delete.html
(normal-erase-is-backspace-mode 1)
;; https://stackoverflow.com/questions/2627289/how-to-replace-a-region-in-emacs-with-yank-buffer-contents
(delete-selection-mode 1)

;; https://www.flycheck.org/en/latest/user/troubleshooting.html#flycheck-macos-exec-path-from-shell
(exec-path-from-shell-initialize)