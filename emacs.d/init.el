;;{{{ Encoding

; Set up multilingual environment to use UTF-8.
(set-language-environment "UTF-8")

; Use UTF-8 as default coding system for files, comint processes and buffers.
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)

;;}}}
;;{{{ Paths

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

;;}}}
;;{{{ Identity

(setq user-full-name    "Sylvain Laperche"
      user-mail-address "sylvain.laperche@gmail.com")

;;}}}
;;{{{ General settings

; Backups
(setq make-backup-files    t  ; Do backup.
      backup-by-copying    t  ; Copying has less side-effects than renaming.
      version-control      t  ; Keep a series of numbered backup files.
      kept-new-versions    10 ; Number of latest versions to keep.
      kept-old-versions    0  ; Don't keep old versions.
      delete-old-versions  t  ; Don't ask to delete excess backup versions.
      vc-make-backup-files t) ; I don't commit on every save so it's useful.

; History
(setq history-delete-duplicates        t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))
(savehist-mode 1)

; Misc.
(setq-default indent-tabs-mode  nil)    ; Use spaces for indentation.
(setq-default fill-column       80)     ; Maximum width of a line.

(setq sentence-end-double-space nil)    ; Sentences end with a single space!

;;}}}
;;{{{ User interface

; (load-theme 'solarized t)

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

;;}}}
