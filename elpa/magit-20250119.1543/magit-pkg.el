;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "magit" "20250119.1543"
  "A Git porcelain inside Emacs."
  '((emacs         "27.1")
    (compat        "30.0.1.0")
    (dash          "2.19.1")
    (magit-section "4.2.0")
    (seq           "2.24")
    (transient     "0.8.2")
    (with-editor   "3.4.3"))
  :url "https://github.com/magit/magit"
  :commit "8f15054d095e146917d0578062ba92b4f2eca125"
  :revdesc "8f15054d095e"
  :keywords '("git" "tools" "vc")
  :authors '(("Marius Vollmer" . "marius.vollmer@gmail.com")
             ("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev"))
  :maintainers '(("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev")
                 ("Kyle Meyer" . "kyle@kyleam.com")))
