;;; smartparens-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from smartparens.el

(autoload 'sp-cheat-sheet "smartparens" "\
Generate a cheat sheet of all the smartparens interactive functions.

Without a prefix argument, print only the short documentation and examples.

With non-nil prefix argument ARG, show the full documentation for each function.

You can follow the links to the function or variable help page.
To get back to the full list, use \\[help-go-back].

You can use `beginning-of-defun' and `end-of-defun' to jump to
the previous/next entry.

Examples are fontified using the `font-lock-string-face' for
better orientation.

(fn &optional ARG)" t)
(defvar smartparens-mode-map (make-sparse-keymap) "\
Keymap used for `smartparens-mode'.")
(autoload 'sp-use-paredit-bindings "smartparens" "\
Initiate `smartparens-mode-map' with `sp-paredit-bindings'." t)
(autoload 'sp-use-smartparens-bindings "smartparens" "\
Initiate `smartparens-mode-map' with `sp-smartparens-bindings'." t)
(autoload 'smartparens-mode "smartparens" "\
Toggle smartparens mode.

You can enable pre-set bindings by customizing
`sp-base-key-bindings' variable.  The current content of
`smartparens-mode-map' is:

 \\{smartparens-mode-map}

This is a minor mode.  If called interactively, toggle the
`Smartparens mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `smartparens-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t)
(autoload 'smartparens-strict-mode "smartparens" "\
Toggle the strict smartparens mode.

When strict mode is active, `delete-char', `kill-word' and their
backward variants will skip over the pair delimiters in order to
keep the structure always valid (the same way as `paredit-mode'
does).  This is accomplished by remapping them to
`sp-delete-char' and `sp-kill-word'.  There is also function
`sp-kill-symbol' that deletes symbols instead of words, otherwise
working exactly the same (it is not bound to any key by default).

When strict mode is active, this is indicated with \"/s\"
after the smartparens indicator in the mode list.

This is a minor mode.  If called interactively, toggle the
`Smartparens-Strict mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `smartparens-strict-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t)
(put 'smartparens-global-strict-mode 'globalized-minor-mode t)
(defvar smartparens-global-strict-mode nil "\
Non-nil if Smartparens-Global-Strict mode is enabled.
See the `smartparens-global-strict-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `smartparens-global-strict-mode'.")
(custom-autoload 'smartparens-global-strict-mode "smartparens" nil)
(autoload 'smartparens-global-strict-mode "smartparens" "\
Toggle Smartparens-Strict mode in all buffers.
With prefix ARG, enable Smartparens-Global-Strict mode if ARG is
positive; otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Smartparens-Strict mode is enabled in all buffers where
`turn-on-smartparens-strict-mode' would do it.

See `smartparens-strict-mode' for more information on
Smartparens-Strict mode.

(fn &optional ARG)" t)
(autoload 'turn-on-smartparens-strict-mode "smartparens" "\
Turn on `smartparens-strict-mode'." t)
(autoload 'turn-off-smartparens-strict-mode "smartparens" "\
Turn off `smartparens-strict-mode'." t)
(put 'smartparens-global-mode 'globalized-minor-mode t)
(defvar smartparens-global-mode nil "\
Non-nil if Smartparens-Global mode is enabled.
See the `smartparens-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `smartparens-global-mode'.")
(custom-autoload 'smartparens-global-mode "smartparens" nil)
(autoload 'smartparens-global-mode "smartparens" "\
Toggle Smartparens mode in all buffers.
With prefix ARG, enable Smartparens-Global mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Smartparens mode is enabled in all buffers where
`turn-on-smartparens-mode' would do it.

See `smartparens-mode' for more information on Smartparens mode.

(fn &optional ARG)" t)
(autoload 'turn-on-smartparens-mode "smartparens" "\
Turn on `smartparens-mode'.

This function is used to turn on `smartparens-global-mode'.

By default `smartparens-global-mode' ignores buffers with
`mode-class' set to special, but only if they are also not comint
buffers.

Additionally, buffers on `sp-ignore-modes-list' are ignored.

You can still turn on smartparens in these mode manually (or
in mode's startup-hook etc.) by calling `smartparens-mode'." t)
(autoload 'turn-off-smartparens-mode "smartparens" "\
Turn off `smartparens-mode'." t)
(autoload 'show-smartparens-mode "smartparens" "\
Toggle visualization of matching pairs.  When enabled, any

matching pair is highlighted after `sp-show-pair-delay' seconds
of Emacs idle time if the point is immediately in front or after
a pair.  This mode works similarly to `show-paren-mode', but
support custom pairs.

This is a minor mode.  If called interactively, toggle the
`Show-Smartparens mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `show-smartparens-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t)
(put 'show-smartparens-global-mode 'globalized-minor-mode t)
(defvar show-smartparens-global-mode nil "\
Non-nil if Show-Smartparens-Global mode is enabled.
See the `show-smartparens-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `show-smartparens-global-mode'.")
(custom-autoload 'show-smartparens-global-mode "smartparens" nil)
(autoload 'show-smartparens-global-mode "smartparens" "\
Toggle Show-Smartparens mode in all buffers.
With prefix ARG, enable Show-Smartparens-Global mode if ARG is
positive; otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Show-Smartparens mode is enabled in all buffers where
`turn-on-show-smartparens-mode' would do it.

See `show-smartparens-mode' for more information on Show-Smartparens
mode.

(fn &optional ARG)" t)
(autoload 'turn-on-show-smartparens-mode "smartparens" "\
Turn on `show-smartparens-mode'.

This function is used to turn on `show-smartparens-global-mode'.

Major modes on `sp-ignore-modes-list' are ignored when turning on
the globalized mode.

You can still turn on `show-smartparens-mode' manually by calling
\\[show-smartparens-mode.]" t)
(autoload 'turn-off-show-smartparens-mode "smartparens" "\
Turn off `show-smartparens-mode'." t)
(register-definition-prefixes "smartparens" '("smartparens-" "sp-"))


;;; Generated autoloads from smartparens-clojure.el

(register-definition-prefixes "smartparens-clojure" '("sp-clojure-prefix"))


;;; Generated autoloads from smartparens-config.el

(register-definition-prefixes "smartparens-config" '("sp-lisp-in"))


;;; Generated autoloads from smartparens-crystal.el

(register-definition-prefixes "smartparens-crystal" '("sp-crystal-"))


;;; Generated autoloads from smartparens-elixir.el

(register-definition-prefixes "smartparens-elixir" '("sp-elixir-"))


;;; Generated autoloads from smartparens-ess.el

(register-definition-prefixes "smartparens-ess" '("sp-ess-"))


;;; Generated autoloads from smartparens-haskell.el

(register-definition-prefixes "smartparens-haskell" '("sp-"))


;;; Generated autoloads from smartparens-html.el

(register-definition-prefixes "smartparens-html" '("sp-html-"))


;;; Generated autoloads from smartparens-javascript.el

(register-definition-prefixes "smartparens-javascript" '("sp-"))


;;; Generated autoloads from smartparens-latex.el

(register-definition-prefixes "smartparens-latex" '("sp-latex-"))


;;; Generated autoloads from smartparens-lua.el

(register-definition-prefixes "smartparens-lua" '("sp-lua-post-keyword-insert"))


;;; Generated autoloads from smartparens-markdown.el

(register-definition-prefixes "smartparens-markdown" '("sp-"))


;;; Generated autoloads from smartparens-org.el

(register-definition-prefixes "smartparens-org" '("sp-"))


;;; Generated autoloads from smartparens-python.el

(register-definition-prefixes "smartparens-python" '("sp-python-"))


;;; Generated autoloads from smartparens-rst.el

(register-definition-prefixes "smartparens-rst" '("sp-rst-point-after-backtick"))


;;; Generated autoloads from smartparens-ruby.el

(register-definition-prefixes "smartparens-ruby" '("sp-"))


;;; Generated autoloads from smartparens-rust.el

(register-definition-prefixes "smartparens-rust" '("sp-"))


;;; Generated autoloads from smartparens-scala.el

(register-definition-prefixes "smartparens-scala" '("sp-scala-wrap-with-indented-newlines"))


;;; Generated autoloads from smartparens-swift.el

(register-definition-prefixes "smartparens-swift" '("sp-swift-"))


;;; Generated autoloads from smartparens-text.el

(register-definition-prefixes "smartparens-text" '("sp-text-mode-"))


;;; Generated autoloads from sp-sublimetext-like.el

(register-definition-prefixes "sp-sublimetext-like" '("sp-point-not-before-word"))

;;; End of scraped data

(provide 'smartparens-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; smartparens-autoloads.el ends here
