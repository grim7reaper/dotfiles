;; -*- lexical-binding: t; -*-
;; Encoding {{{

; Set up multilingual environment to use UTF-8.
(set-language-environment "UTF-8")

; Use UTF-8 as default coding system for files, comint processes and buffers.
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)

;; }}}
;; Paths {{{

; Emacs's home :)
(setq user-emacs-directory "~/.emacs.d/")

; A small helper function to define paths into Emacs's home directory.
(defun prepend-emacs-home (name)
  "Expand NAME to an absolute path inside `user-emacs-directory`."
  (expand-file-name name user-emacs-directory))

; My Lisp library.
(add-to-list 'load-path (prepend-emacs-home "lisp"))

(setq bookmark-default-file  (prepend-emacs-home "bookmarks")) ; Bookmarks.
(setq savehist-file          (prepend-emacs-home "history"))   ; History
(setq package-user-dir       (prepend-emacs-home "elpa"))      ; Packages.
(setq custom-theme-directory (prepend-emacs-home "themes"))    ; Themes.

; Auto-save.
(setq auto-save-file-name-transforms
      `((".*" ,(prepend-emacs-home "auto-save-list/") t)))

; Backups.
(setq backup-directory-alist
      `(("." . ,(prepend-emacs-home "backups"))))

; Optional customization file.
(setq custom-file (prepend-emacs-home "custom.el"))
(load custom-file t)

;; }}}
;; Packages management {{{

(require 'package)

; We explicitly call `package-initialize`: no need to redo it later.
(setq package-enable-at-startup nil)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

; Bootstrap `use-package` (it is used to install/configure the other packages).
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-verbose       t) ; To always have timing information.
(setq use-package-always-ensure t) ; Always install declared packages.

; Explicit require needed because I modified `use-package-verbose`.
(require 'use-package)

; Try packages without installing them.
(use-package try)

;; }}}
;; Identity {{{

(setq user-full-name    "Sylvain Laperche"
      user-mail-address "sylvain.laperche@gmail.com")

;; }}}
;; General settings {{{
;; Backups {{{

(setq make-backup-files    t  ; Do backup.
      backup-by-copying    t  ; Copying has less side-effects than renaming.
      version-control      t  ; Keep a series of numbered backup files.
      kept-new-versions    10 ; Number of latest versions to keep.
      kept-old-versions    0  ; Don't keep old versions.
      delete-old-versions  t  ; Don't ask to delete excess backup versions.
      vc-make-backup-files t) ; I don't commit on every save so it's useful.

;; }}}
;; History {{{

(setq history-delete-duplicates        t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))
(savehist-mode 1)

; Auto-reload files modified on disk, safely (don't overwrite my own changes).
(global-auto-revert-mode 1)

;; }}}
;; Misc. {{{

(setq-default indent-tabs-mode  nil)    ; Use spaces for indentation.
(setq-default tab-width         4)      ; Indent with 4 spaces by default.
(setq-default fill-column       80)     ; Maximum width of a line.

(setq sentence-end-double-space nil)    ; Sentences end with a single space!
(setq nobreak-char-display      t)      ; Highlight no-break space & cie.

(setq compilation-ask-about-save nil)   ; Automatically save before compiling.

;; }}}
;; }}}
;; User interface {{{

(setq visible-bell           t)   ; Use visible bell, not the audible one.
(setq inhibit-startup-screen t)   ; No splash screen.
(menu-bar-mode -1)                ; Disable menu bar.

; Modeline
(line-number-mode   t)            ; Display line number in the modeline.
(column-number-mode t)            ; Display column number in the modeline.

; Theme
(use-package solarized-theme)
(load-theme 'solarized-dark t)

(if window-system
  ; In GUI: disable toolbar and scrollbar.
  (progn
    (tool-bar-mode   -1)
    (scroll-bar-mode -1))
  (progn
    ; hack: let the terminal decide the background color.
    ; https://github.com/bbatsov/solarized-emacs/issues/18#issuecomment-31434473
    (custom-set-faces '(default ((t (:background "nil"))))))
)

; Displays available keybindings in popup (good for discoverability).
(use-package which-key
  :config
  (which-key-mode))

;; ivy {{{

(use-package ivy
  :config
  (ivy-mode 1))

(use-package swiper
  :bind
  ("C-s" . swiper))

;; }}}
;; avy {{{

(use-package avy
  :bind
  ("M-g c" . avy-goto-char)
  ("M-g f" . avy-goto-line)
  ("M-g w" . avy-goto-word-1))

;; }}}
;; ibuffer {{{

; Use ibuffer instead of list-buffers.
(global-set-key (kbd "C-x C-b") 'ibuffer)

; Don't ask for confirmation to delete unmodified buffers.
(setq ibuffer-expert t)

(add-hook 'ibuffer-mode-hook #'my-ibuffer-hook)

(defun my-ibuffer-hook ()
  (ibuffer-auto-mode 1)) ; Keeps the buffer list up to date.

; Group buffers in ibuffer list by project (as long as they use a VCS).
(use-package ibuffer-vc
  :hook
  (ibuffer-mode . (lambda ()
                    (ibuffer-vc-set-filter-groups-by-vc-root)))
)

;; }}}
;; Whitespace {{{

; Highlight tabs and trailing spaces.
(setq whitespace-style '(face lines-tail trailing tabs tab-mark))
(global-whitespace-mode 1)

;; }}}
;; Windows management {{{

; Allow to move between windows using using Shift and the arrow keys
(windmove-default-keybindings)

; Records the changes in the window configuration (to allow undoes).
(winner-mode 1)

; use `ace-window` instead of `other-window`.
(use-package ace-window
  :init
  (global-set-key [remap other-window] 'ace-window))

;; }}}
;; }}}
;; evil {{{

(use-package evil
  :config
  (evil-mode 1))

;; }}}
;; Org {{{

; Keep a consistent indentation for the second line of a description list.
(setq org-list-description-max-indent 5)

; Enable syntax highlighting for code blocks.
(setq org-src-fontify-natively t)

;; LaTeX {{{

(require 'ox-latex)

;; Code highlighting {{{

; Use `minted` for code highlighting when exporting to LaTeX
; XXX: this depends on `pygments` (http://pygments.org).

; Export source code using the `minted` package.
(setq org-latex-listings 'minted)

; Use the `minted` package in every generared LaTeX files.
(setq org-latex-packages-alist '(("" "minted")))

; Commands to process a LaTeX file to a PDF file.
(setq org-latex-pdf-process
  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; }}}
;; }}}
;; }}}
;; Programming {{{

(show-paren-mode 1)  ; Highlights matching parentheses & co.

(use-package cmake-mode)

(use-package flycheck)

;; LSP {{{

(use-package lsp-mode
  :commands lsp
  :custom
  ;; Use clippy as check command.
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  ;; Display all the info, not only the symbol info.
  (lsp-eldoc-render-all t)
  :hook
  (lsp-mode-hook . lsp-ui-mode))

(use-package lsp-ui
  :commands lsp-ui-mode
  :custom
  ;; Show hover messages in sideline.
  (lsp-ui-sideline-show-hover t)
  ;; Don't show documentation in a child frame.
  (lsp-ui-doc-enable nil))

;; }}}
;; Auto-completion {{{

(use-package company)

; Enable Company globally.
(add-hook 'after-init-hook 'global-company-mode)

;; }}}
;; Origami {{{

; Use origami as replacement for Vim's folds based on markers.
(use-package origami
  :hook
  (origami-mode . my-origami-hook)
  ((prog-mode conf-mode yaml-mode slang-mode) . origami-mode)
  ; Use Vim-like keybindings.
  :bind (:map evil-normal-state-map
              ("zo" . my-open-fold)
              ("zO" . my-open-fold-recursively)
              ("zc" . my-close-fold)
              ("zC" . my-close-fold-recursively)
              ("za" . origami-forward-toggle-node)
              ("zA" . my-toggle-fold-recursively)
              ("zM" . origami-close-all-nodes)
              ("zR" . origami-open-all-nodes)))

(defun my-origami-hook ()
  ; Always use marker-based folding.
  (setq-local origami-fold-style 'triple-braces)
  ; Starts with all the fold closed.
  (origami-close-all-nodes (current-buffer)))

;; Origami helpers {{{

; Helpers to have a Vim-like behavior.
;
; The wrapper allows the open/close functions to works even if we aren't exactly
; on the fold node.
;
; The recursive toggle is a Vim-like toggle, unlike the one from origami which
; is similar to an org-like cycle.

(defun fold-wrapper (fold-fun buffer)
  "Wrapper for origami's fold functions

Origami's fold functions usually require that you are on the fold marker to operate.
With this wrapper, the behavior is more Vim-like."
  (save-excursion
    (end-of-line)
    (origami-previous-fold buffer (point))
    (funcall fold-fun buffer (point))))

(defun my-open-fold (buffer)
  "If the current line contains a closed fold, open it."
  (interactive (list (current-buffer)))
  (fold-wrapper 'origami-open-node buffer))

(defun my-open-fold-recursively (buffer)
  "If the current line contains a closed fold, open it and all of its children."
  (interactive (list (current-buffer)))
  (fold-wrapper 'origami-open-node-recursively buffer))

(defun my-close-fold (buffer)
  "If we are inside/onto an open fold, close it."
  (interactive (list (current-buffer)))
  (fold-wrapper 'origami-close-node buffer))

(defun my-close-fold-recursively (buffer)
  "If we are inside/onto an open fold, close it and all of its children."
  (interactive (list (current-buffer)))
  (fold-wrapper 'origami-close-node-recursively buffer))

(defun my-toggle-fold-recursively (buffer point)
  "Toggle recursively the current fold.

If the current line contains a closed fold, open it and all of its children.
If we are inside/onto an open fold, close it and all of its children."
  (interactive (list (current-buffer) (point)))
  (-when-let (path (origami-search-forward-for-path buffer point))
    (let ((node (-last-item path)))
        (if (origami-fold-open? node)
            (origami-close-node-recursively buffer (origami-fold-beg node))
          (origami-open-node-recursively buffer (origami-fold-beg node))))))

;; }}}
;; }}}
;; C++ {{{

; Treat *.tpp (C++ template implementation) files as C++.
(add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))

;; }}}
;; Go {{{

; Depends on golang.org/x/tools/cmd/goimports
(use-package go-mode
  :init
  (setq gofmt-command "goimports")  ; Use goimports instead of gofmt.
  :hook
  (before-save . gofmt-before-save) ; Reformat when saving.
  (go-mode . (lambda ()             ; Don't highlight tab (gofmt enforce tabs…).
               (set
                (make-local-variable 'whitespace-style)
                '(face lines-tail trailing))))
)

; Depends on github.com/stamblerre/gocode
(use-package company-go
  :init
  (setq company-go-show-annotation t)  ; Show functions prototype.
  :hook
  ; Load Go completion backend when loading Go mode.
  (go-mode . (lambda ()
               (set (make-local-variable 'company-backends) '(company-go))))
)

;; }}}
;; Rust {{{

(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-l" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ; Call `rustfmt' on save.
  (setq rustic-format-on-save t)
  ; Use nightly rustfmt (stable doesn't handle all the options).
  (setq rustic-rustfmt-bin "~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustfmt")
  :hook
  (rustic-mode-hook . (lambda ()
               ;; so that rustic-cargo-run works without having to confirm.
               (setq-local buffer-save-without-query t))))

;; }}}
;; Docker {{{

(use-package dockerfile-mode
  :init
  (setq dockerfile-use-sudo t))

;; }}}
;; S-Lang {{{

(autoload 'slang-mode "slang-mode"
  "Mode for editing slang source files")
(setq auto-mode-alist
      (append '(("\\.sl$" . slang-mode)) auto-mode-alist))

;; }}}
;; }}}
;; Misc. {{{
;; Ledger {{{

(use-package ledger-mode
  :mode "\\.ledger$"
  :hook
  (ledger-mode . outline-minor-mode))

;; }}}
;; Markdown {{{

(use-package markdown-mode
  :commands
  (markdown-mode gfm-mode)
  :mode
  ("README\\.md\\'" . gfm-mode)
  :init
  (setq markdown-command "pandoc")
  (setq markdown-asymmetric-header t)
  (setq markdown-fontify-code-blocks-natively t))

; To be able to edit code blocks in indirect buffers using `C-c '`
(use-package edit-indirect)

;; }}}
;; YAML {{{

(use-package yaml-mode)

;; }}}
;; vimrc {{{

(use-package vimrc-mode)

;; }}}
;; }}}
