;;; copilot-chat --- copilot-chat-org.el --- copilot chat interface, org frontend -*- indent-tabs-mode: nil; lisp-indent-offset: 2; lexical-binding: t -*-

;; Copyright (C) 2024  copilot-chat maintainers

;; The MIT License (MIT)

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:


;;; Code:

(require 'org)


(defun copilot-chat--org-format-data(content type)
  "Format data for org frontend.
Argument CONTENT is the data to format.
Argument TYPE is the type of the data (prompt or answer)."
  (let ((data ""))
    (if (eq type 'prompt)
	  (progn
	    (setq copilot-chat--first-word-answer t)
	    (setq data (concat "\n* " (format-time-string "*[%T]* You                 :you:\n") (format "%s\n" content))))
	  (when copilot-chat--first-word-answer
	    (setq copilot-chat--first-word-answer nil)
        (setq data (concat "\n** " (format-time-string "*[%T]* Copilot                 :copilot:\n"))))
	  (setq data (concat data content)))
    data))

(defun copilot-chat--org-create-req (orig-fun &rest args)
  "Advice to modify the PROMPT argument before executing the original function."
  (let ((prompt (concat (nth 0 args) "\n\n(Remember: please use only emacs org-mode syntax))"))
        (no-context (nth 1 args)))
    (apply orig-fun (list prompt no-context))))

(defun copilot-chat--org-clean()
  "Clean the copilot chat org frontend."
  (advice-remove 'copilot-chat--format-data #'copilot-chat--org-format-data)
  (advice-remove 'copilot-chat--clean #'copilot-chat--org-clean)
  (advice-remove 'copilot-chat--create-req #'copilot-chat--org-create-req))

(defun copilot-chat--get-org-block-content-at-point ()
  "Get the content of the org block at point."
  (let* ((element (org-element-at-point))
         (type (org-element-type element)))
    (when (memq type '(src-block quote-block example-block))
      (let ((content (org-element-property :value element)))
        content))))

(defun copilot-chat--get-language-mode (element)
  "Get major mode name from org source block language."
  (when (eq (org-element-type element) 'src-block)
    (let ((language (org-element-property :language element)))
      (org-src-get-lang-mode language))))

(defun copilot-chat--find-matching-buffer (mode)
  "Find most recent buffer with major-mode matching MODE."
  (seq-find (lambda (buf)
              (with-current-buffer buf
                (eq major-mode mode)))
            (buffer-list)))

(defun copilot-chat-org-send-to-buffer (buffer)
  "Send the code block at point to buffer.
Replace selection if any."
  (interactive
   (let* ((element (org-element-at-point))
          (mode (copilot-chat--get-language-mode element))
          (matching-buffer (when mode (copilot-chat--find-matching-buffer mode)))
          (default-buffer (or matching-buffer (current-buffer))))
     (list
      (completing-read "Choose buffer: "
                      (mapcar #'buffer-name (buffer-list))
                      nil  ; PREDICATE
                      t    ; REQUIRE-MATCH
                      nil  ; INITIAL-INPUT
                      'buffer-name-history
                      (buffer-name default-buffer)))))
  (let ((content (copilot-chat--get-org-block-content-at-point)))
    (when content
      (with-current-buffer buffer
        (when (use-region-p)
          (delete-region (region-beginning) (region-end)))
        (insert content))
      (let ((window (get-buffer-window buffer)))
        (if window
          (select-window window)
          (switch-to-buffer buffer))))))

(defun copilot-chat--org-get-code-blocks-under-heading (heading-regex)
  "Get source blocks under headings matching HEADING-REGEX."
  (let ((blocks))
    (org-map-entries
      (lambda ()
        (let* ((heading-end (save-excursion (org-end-of-subtree t)))
                (element-start (point)))
          (setq blocks
            (append blocks
              (org-element-map
                (org-element-parse-buffer 'element)
                'src-block
                (lambda (src-block)
                  (when (and (>= (org-element-property :begin src-block) element-start)
                          (<= (org-element-property :begin src-block) heading-end))
                    (list :language (org-element-property :language src-block)
                      :content (org-element-property :value src-block)
                      :begin (org-element-property :begin src-block)
                      :end (org-element-property :end src-block)))))))))
      heading-regex)
    (seq-uniq blocks #'equal)))

(defun copilot-chat--org-yank()
  (let ((content ""))
	(with-current-buffer copilot-chat--buffer
	  (let ((blocks (copilot-chat--org-get-code-blocks-under-heading "copilot")))
        (when blocks
		  (while (< copilot-chat--yank-index 1)
			(setq copilot-chat--yank-index (+ (length blocks)
                                             copilot-chat--yank-index)))
          (when (> copilot-chat--yank-index (length blocks))
			(setq copilot-chat--yank-index (- copilot-chat--yank-index
                                             (length blocks))))
		  (setq content (plist-get (car (last blocks copilot-chat--yank-index)) :content)))))
	;; Delete previous yank if exists
    (when (and copilot-chat--last-yank-start
               copilot-chat--last-yank-end)
	  (delete-region copilot-chat--last-yank-start copilot-chat--last-yank-end))
    ;; Insert new content
    (setq copilot-chat--last-yank-start (point))
    (insert content)
    (setq copilot-chat--last-yank-end (point))))

(defun copilot-chat-org-init()
  "Initialize the copilot chat org frontend."
  (setq copilot-chat-prompt "You are a world-class coding tutor. Your code explanations perfectly balance high-level concepts and granular details. Your approach ensures that students not only understand how to write code, but also grasp the underlying principles that guide effective programming.
When asked for your name, you must respond with \"GitHub Copilot\".
Follow the user's requirements carefully & to the letter.
Your expertise is strictly limited to software development topics.
Follow Microsoft content policies.
Avoid content that violates copyrights.
For questions not related to software development, simply give a reminder that you are an AI programming assistant.
Keep your answers short and impersonal.

Use only Emacs org-mode formatting in your answers.
When using heading to structure your answer, please start at level 3 (i.e with 3 stars or more)
Make sure to include the programming language name at the start of the org-mode code blocks.
This is an example of python code block in emacs org-mode syntax:
#+BEGIN_SRC python
def hello_world():
	print('Hello, World!')
#+END_SRC
Avoid wrapping the whole response in the block code.

Don't forget the most important rule when you are formatting your response: use emacs org-mode syntax only.

The user works in an IDE called Emacs which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
The active document is the source code the user is looking at right now.
You can only give one reply for each conversation turn.

Additional Rules
Think step by step:
1. Examine the provided code selection and any other context like user question, related errors, project details, class definitions, etc.
2. If you are unsure about the code, concepts, or the user's question, ask clarifying questions.
3. If the user provided a specific question or error, answer it based on the selected code and additional provided context. Otherwise focus on explaining the selected code.
4. Provide suggestions if you see opportunities to improve code readability, performance, etc.

Focus on being clear, helpful, and thorough without assuming extensive prior knowledge.
Use developer-friendly terms and analogies in your explanations.
Identify 'gotchas' or less obvious parts of the code that might trip up someone new.
Provide clear and relevant examples aligned with any provided context.
")

  (define-derived-mode copilot-chat-mode org-mode "Copilot Chat"
	"Major mode for the Copilot Chat buffer."
	(read-only-mode 1))

  (define-derived-mode copilot-chat-prompt-mode org-mode "Copilot Chat Prompt")

  (advice-add 'copilot-chat--format-data :override #'copilot-chat--org-format-data)
  (advice-add 'copilot-chat--clean :after #'copilot-chat--org-clean)
  (advice-add 'copilot-chat--create-req :around #'copilot-chat--org-create-req)

  (advice-add 'copilot-chat-send-to-buffer :override #'copilot-chat-org-send-to-buffer)
  (advice-add 'copilot-chat--yank :override #'copilot-chat--org-yank))

(provide 'copilot-chat-org)
;;; copilot-chat-org.el ends here
