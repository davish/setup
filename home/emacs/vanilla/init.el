;; Remove GUI elements
(tool-bar-mode -1)             ; Hide the outdated icons
(scroll-bar-mode -1)           ; Hide the always-visible scrollbar
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)      ; Ask for textual confirmation instead of GUI

;; Set up straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
    (expand-file-name
      "straight/repos/straight.el/bootstrap.el"
      (or (bound-and-true-p straight-base-dir)
        user-emacs-directory)))
    (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

(use-package emacs
  :init
  (setq initial-scratch-message nil)
  (defun display-startup-echo-area-message ()
    (message ""))
  (defalias 'yes-or-no-p 'y-or-n-p))

;; utf-8 all the things
(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix)))

;; tabs
(use-package emacs
  :init
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))

;; macos keybindings
(use-package emacs
  :init
	(when (eq system-type 'darwin)
		(setq mac-command-modifier 'super)
		(setq mac-option-modifier 'meta)
		(setq mac-control-modifier 'control)))

;; font
(use-package emacs
  :init
  (set-face-attribute 'default nil
    :font "JetBrains Mono"
    :height 120))

(use-package emacs
  :init
  (defun ab/enable-line-numbers ()
    "Enable relative line numbers"
    (interactive)
    (display-line-numbers-mode)
    (setq display-line-numbers 'relative))
  (add-hook 'prog-mode-hook #'ab/enable-line-numbers)
  (add-hook 'markdown-mode-hook #'ab/enable-line-numbers))

(use-package emacs
  :init
	(global-set-key (kbd "<escape>") 'keyboard-escape-quit))

(use-package gcmh
  :demand
  :config
  (gcmh-mode 1))   

(use-package evil
  :demand ; No lazy loading
  :config
  (evil-mode 1))

(use-package doom-themes
  :demand
  :config
  (load-theme 'doom-nord-light t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons)

(use-package which-key
  :demand
  :init
  (setq which-key-idle-delay 0.25) ; Open after .5s instead of 1s
  :config
  (which-key-mode))

(use-package ivy
  :demand
  :config
  (ivy-mode))

(use-package general
  :demand
  :config
  (general-evil-setup)

  (general-create-definer leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (leader-keys
    "SPC" '(execute-extended-command :which-key "execute command")

    "q" '(:ignore t :which-key "quit")
    "q q" '(save-buffers-kill-emacs :which-key "quit emacs")

    "r" '(restart-emacs :whick-key "restart emacs")
    "i" '((lambda () (interactive) (find-file "~/.config/nix/home/emacs/vanilla/init.el")) :which-key "open init file")

    ;; Buffer
    "b" '(:ignore t :which-key "buffer")
    ;; Don't show an error because SPC b ESC is undefined, just abort
    "b <escape>" '(keyboard-escape-quit :which-key t)
    "bd"  'kill-current-buffer
  ))

(use-package projectile
  :demand
  :general
  (leader-keys
    :states 'normal
    "b f" '(projectile-find-file :which-key "find file")

    ;; Buffers
    "b b" '(projectile-switch-to-buffer :which-key "switch buffer")

    ;; Projects
    "p" '(:ignore t :which-key "projects")
    "p <escape>" '(keyboard-escape-quit :which-key t)
    "p p" '(projectile-switch-project :which-key "switch project")
    "p a" '(projectile-add-known-project :which-key "add project")
    "p r" '(projectile-remove-known-project :which-key "remove project"))
  :init
  (projectile-mode +1))

(use-package markdown-mode
    :general
    (:keymaps 'markdown-mode-map
    "s-H" 'markdown-promote
    "s-J" 'markdown-move-down
    "s-K" 'markdown-move-up
    "s-L" 'markdown-demote
    "s-j" 'markdown-next-visible-heading
    "s-k" 'markdown-previous-visible-heading
    ))

(use-package markdown-mode
    :general
    (:keymaps 'markdown-mode-map :states 'normal
        "TAB" 'evil-toggle-fold))

