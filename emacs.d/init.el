;; * Encoding

; Set up multilingual environment to use UTF-8.
(set-language-environment "UTF-8")

; Use UTF-8 as default coding system for files, comint processes and buffers.
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)

;; * Paths

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

;; * Packages management

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

;; * Identity

(setq user-full-name    "Sylvain Laperche"
      user-mail-address "sylvain.laperche@gmail.com")

;; * General settings
;; ** Backups
(setq make-backup-files    t  ; Do backup.
      backup-by-copying    t  ; Copying has less side-effects than renaming.
      version-control      t  ; Keep a series of numbered backup files.
      kept-new-versions    10 ; Number of latest versions to keep.
      kept-old-versions    0  ; Don't keep old versions.
      delete-old-versions  t  ; Don't ask to delete excess backup versions.
      vc-make-backup-files t) ; I don't commit on every save so it's useful.

;; ** History
(setq history-delete-duplicates        t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))
(savehist-mode 1)

;; ** Misc.
(setq-default indent-tabs-mode  nil)    ; Use spaces for indentation.
(setq-default tab-width         4)      ; Indent with 4 spaces by default.
(setq-default fill-column       80)     ; Maximum width of a line.

(setq sentence-end-double-space nil)    ; Sentences end with a single space!
(setq nobreak-char-display      t)      ; Highlight no-break space & cie.

(setq compilation-ask-about-save nil)   ; Automatically save before compiling.

;; * User interface

(setq visible-bell           t)   ; Use visible bell, not the audible one.
(setq inhibit-startup-screen t)   ; No splash screen.
(menu-bar-mode -1)                ; Disable menu bar.

; Modeline
(line-number-mode   t)            ; Display line number in the modeline.
(column-number-mode t)            ; Display column number in the modeline.

; In GUI use white text on black background and disable toolbar and scrollbar.
(if window-system
  (progn
    (set-foreground-color "white")
    (set-background-color "black")
    (tool-bar-mode   -1)
    (scroll-bar-mode -1))
)

; Displays available keybindings in popup (good for discoverability).
(use-package which-key
  :config
  (which-key-mode))

; Display a ruler to represent the fill column.
(use-package fill-column-indicator
  :hook
  ((prog-mode text-mode) . fci-mode))

;; ** Interactively DO things

(require 'ido)

(setq ido-everywhere            t        ; Use it for buffer and file selection.
      ido-enable-flex-matching  t        ; Flexible matching is the best!
      ido-ignore-extensions     t        ; Use `completion-ignored-extensions`.
      ido-create-new-buffer     'always) ; Don't ask before creating new buffer.
(ido-mode 1)

;; ** ibuffer

; Use ibuffer instead of list-buffers.
(global-set-key (kbd "C-x C-b") 'ibuffer)

; Don't ask for confirmation to delete unmodified buffers.
(setq ibuffer-expert t)

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1))) ; Keeps the buffer list up to date.

;; ** Whitespace

; Highlight tabs and trailing spaces.
(setq whitespace-style '(face trailing tabs tab-mark))
(global-whitespace-mode 1)

;; ** Windows management

; Allow to move between windows using using Shift and the arrow keys
(windmove-default-keybindings)

; Records the changes in the window configuration (to allow undoes).
(winner-mode 1)

; use `ace-window` instead of `other-window`.
(use-package ace-window
  :init
  (global-set-key [remap other-window] 'ace-window))

;; * evil

(use-package evil
  :config
  (evil-mode 1))

;; * Org

; Keep a consistent indentation for the second line of a description list.
(setq org-list-description-max-indent 5)

; Enable syntax highlighting for code blocks.
(setq org-src-fontify-natively t)

;; ** LaTeX

(require 'ox-latex)

;; *** Code highlighting

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

;; * Programming

(show-paren-mode 1)  ; Highlights matching parentheses & co.

(use-package cmake-mode)

;; ** Auto-completion

(use-package company)

; Workaround to be compatible with Fill-Column-Indicator.
; See https://github.com/alpaker/Fill-Column-Indicator/issues/54#issuecomment-218344694
(defun on-off-fci-before-company(command)
  (when (string= "show" command)
    (turn-off-fci-mode))
  (when (string= "hide" command)
    (turn-on-fci-mode)))

(advice-add 'company-call-frontends :before #'on-off-fci-before-company)

; Enable Company globally.
(add-hook 'after-init-hook 'global-company-mode)

;; ** Outshine

; Use outline as replacement for Vim's folds based on markers.
(use-package outshine
  :init
  (setq outshine-startup-folded-p   t)
  (setq outshine-use-speed-commands t)
  :hook
  (outline-minor-mode . outshine-hook-function)
  (prog-mode          . outline-minor-mode))

;; ** Rust

(use-package rust-mode
  :init
  (setq rust-format-on-save      t)  ; Call `rustfmt' on save.
  (setq rust-indent-offset       4)  ; Indent with 4 spaces.
  (setq rust-indent-method-chain t)  ; Indent method chains, aligned on '.'.
  (setq rust-indent-where-clause t)) ; Indent the line starting with `where'.

(use-package cargo
  :hook
  (rust-mode . cargo-minor-mode))

;; ** Docker

(use-package dockerfile-mode
  :init
  (setq dockerfile-use-sudo t))

;; * Misc.
;; ** Ledger

(use-package ledger-mode
  :mode "\\.ledger$"
  :hook
  (ledger-mode . outline-minor-mode))

;; ** Markdown

(use-package markdown-mode
  :commands
  (markdown-mode gfm-mode)
  :mode
  ("README\\.md\\'" . gfm-mode)
  :init
  (setq markdown-command "pandoc")
  (setq markdown-asymmetric-header t)
  (setq markdown-hide-markup       t)
  (setq markdown-fontify-code-blocks-natively t))

; To be able to edit code blocks in indirect buffers using `C-c '`
(use-package edit-indirect)
