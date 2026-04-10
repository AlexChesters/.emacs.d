# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Emacs configuration using MELPA packages managed via `use-package`. There are no build, lint, or test commands — changes take effect by reloading Emacs or evaluating individual buffers.

## File Structure

- **init.el** — Entry point. Sets GC tuning, loads MELPA, then loads all files from `config/` in order.
- **config/packages.el** — All `use-package` declarations; the primary place to add, remove, or configure packages.
- **config/keys.el** — Global keybindings.
- **config/functions.el** — Custom Elisp utility functions.
- **config/appearance.el** — Theme, font, mode line, line numbers.
- **config/misc.el** — Miscellaneous editor behavior (indentation, completion, electric pairs, etc.).
- **elpa/** — Installed packages; do not edit directly.

## Architecture

The config is deliberately flat — no subdirectories under `config/`, no dynamic file loading, no custom package manager wrappers. Each file has a single clear responsibility. When adding new functionality, prefer adding to an existing file over creating a new one, unless the scope clearly warrants it.

Package configuration lives entirely in `packages.el` using `use-package` with `:defer t` where possible. Keybindings for packages belong in `keys.el` unless the binding only makes sense inside a `use-package` `:bind` or `:hook` block.

## Key Packages

- **Vertico + Orderless + Marginalia + vertico-prescient** — Completion UI stack (replaces ivy/helm)
- **Projectile** — Project management; searches `~/workspace/` and `~/code/`
- **Magit** — Git interface (deferred; bound under `C-c v`)
- **Copilot** — GitHub Copilot, enabled in `prog-mode`, Tab to accept
- **Flycheck** — Linting in `prog-mode`
- **Swiper** — Incremental search (bound to `Cmd+S`)
- **Neotree** — File tree (bound to `Cmd+F`)
- **cfn-mode** — AWS CloudFormation YAML/JSON, loaded via `magic-mode-alist`
