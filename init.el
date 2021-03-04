; ;; ----------------------------------------------------------------------------
; ;; Initialization
; ;; ----------------------------------------------------------------------------

(setq inhibit-startup-message t)   ;; No startup page
(setq initial-scratch-message nil) ;; No *scratch* buffer message
(menu-bar-mode 0)                  ;; No menubar
(tool-bar-mode 0)                  ;; No toolbar
(tooltip-mode  0)                  ;; No tooltip
(scroll-bar-mode 0)                ;; Noe scrollbar
(blink-cursor-mode 0)              ;; No blinking cursor
(setq pop-up-windows nil)          ;; No popup windows


; ;; ----------------------------------------------------------------------------
; ;; Geometry
; ;; ----------------------------------------------------------------------------

;; Internal border: 10 pixels
(modify-frame-parameters (selected-frame)
                         '((internal-border-width . 10)))
;; Default frame size and border
; (setq default-frame-alist (append (list
;                           '(width . 50) '(height .  100)
;                           '(top   . 50) '(left   . 250)
;                           '(internal-border-width . 32))
;                           default-frame-alist))

(setq-default frame-title-format "%b")
(setq         frame-title-format "%b")


; ;; ----------------------------------------------------------------------------
; ;; Colorscheme
; ;; ----------------------------------------------------------------------------

(load-theme 'one-dark t)


; ;; ----------------------------------------------------------------------------
; ;; Font
; ;; ----------------------------------------------------------------------------

(set-frame-font "Iosevka 12")
(add-to-list 'default-frame-alist
             '(font . "Iosevka 12"))


; ;; ----------------------------------------------------------------------------
; ;; Headerline
; ;; ----------------------------------------------------------------------------

(add-to-list 'load-path "~/.emacs.d/nano")
(require 'nano-splash)
(require 'nano-modeline)
(require 'nano-base-colors)
(require 'nano-faces)

;; (defun mode-line-fill (face reserve)
;;   "Return empty space using FACE and leaving RESERVE space on the right."
;;   (unless reserve
;;     (setq reserve 20))
;;   (when (and window-system (eq 'right (get-scroll-bar-mode)))
;;     (setq reserve (- reserve 3)))
;;   (propertize " "
;;               'display `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))
;;               'face face))

;; (setq-default header-line-format (list
;;    " "
;;    'mode-line-mule-info
;;    'mode-line-modified
;;    "  "
;;    'mode-line-buffer-identification
;;    'mode-line-modes
;;    " -- "
;;    `(vc-mode vc-mode)

;;    ;; File read-only
;;    '(:eval (if buffer-read-only
;;                (list (mode-line-fill 'nil 13)
;;                      (propertize " [read-only] " 'face 'header-line-grey))))

;;    ;; File modified
;;    '(:eval (if (buffer-modified-p)
;;                (list (mode-line-fill 'nil 12)
;;                      (propertize " [modified] " 'face 'header-line-red))
;;              (list (mode-line-fill 'nil 9)
;;                    (propertize "%4l:%3c " 'face 'header-line))))
;;    ))
;; (setq-default mode-line-format "")


; ;; ----------------------------------------------------------------------------
; ;; Misc
; ;; ----------------------------------------------------------------------------

;; User name
(setq user-full-name "Samarth Kulshrestha")

;; User mail address
(setq user-mail-address "samarthkulshresth@gmail.com")
      
;; No empty line indicators
(setq indicate-empty-lines nil)

;; No cursor in inactive windows
(setq cursor-in-non-selected-windows nil)

;; Org mode is initial mode
(setq initial-major-mode 'org-mode)

;; Org mode is default major mode
(setq default-major-mode 'org-mode)

;; Moderate font lock
(setq font-lock-maximum-decoration nil)

;; No limit on font lock
(setq font-lock-maximum-size nil)

;; No line break space points
(setq auto-fill-mode nil)

;; Fill column at 80
(setq fill-column 80)

;; No confirmation for visiting non-existent files
(setq confirm-nonexistent-file-or-buffer nil)

;; Completion style, see
;; gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html
(setq completion-styles '(basic substring))

;; Navigate windows using shift+direction
(windmove-default-keybindings)

;; Tab behavior
;; (setq tab-always-indent 'complete)
;; (global-company-mode)
;; (define-key company-mode-map [remap indent-for-tab-command]
;;   #'company-indent-or-complete-common)

;; Pixel scroll (as opposed to char scrool)
(pixel-scroll-mode t)

;; y/n for  answering yes/no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; No tabs
(setq-default indent-tabs-mode nil)

;; Tab.space equivalence
(setq tab-width 4)

;; Size of temporary buffers
(temp-buffer-resize-mode)
(setq temp-buffer-max-height 8)

;; Minimum window height
(setq window-min-height 1)

;; Buffer encoding
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment   'utf-8)

;; Unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse
      uniquify-separator " • "
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

;; Default shell in term
(setq-default shell-file-name "/bin/zsh")
(setq explicit-shell-file-name "/bin/zsh")

;; Kill term buffer when exiting
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)


; ;; ----------------------------------------------------------------------------
; ;; Better Defaults
; ;; ----------------------------------------------------------------------------

;; Simple Settings
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(display-time-mode 1)                             ; Enable time in the mode-line
(global-subword-mode 1)                           ; Iterate through CamelCase words

;; Always open Emacs Fullscreen
(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; Better Window Titles
(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))


; ;; ----------------------------------------------------------------------------
; ;; Scroll
; ;; ----------------------------------------------------------------------------
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)


; ;; ----------------------------------------------------------------------------
; ;; Relative Line Numbers
; ;; ----------------------------------------------------------------------------

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-relative-line-numbers)

(defun my-linum-relative-line-numbers (line-number)
  (let ((test2 (- line-number my-linum-current-line-number)))
    (propertize
     (number-to-string (cond ((<= test2 0) (* -1 test2))
                             ((> test2 0) test2)))
     'face 'linum)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)

(global-linum-mode t)


; ;; ----------------------------------------------------------------------------
; ;; Commenter
; ;; ----------------------------------------------------------------------------

;; Vim key bindings
(require 'evil-leader)
(evil-leader/set-key
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "."  'evilnc-copy-and-comment-operator
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
)

; ;; ----------------------------------------------------------------------------
; ;; Writeroom
; ;; ----------------------------------------------------------------------------

;; (setq +zen-text-scale 0.6)

;; (after! writeroom-mode
;;   (add-hook 'writeroom-mode-hook
;;             (defun +zen-cleaner-org ()
;;               (when (and (eq major-mode 'org-mode) writeroom-mode)
;;                 (setq-local -display-line-numbers display-line-numbers
;;                             display-line-numbers nil)
;;                 (setq-local -org-indent-mode org-indent-mode)
;;                 (org-indent-mode -1)
;;                 (when (featurep 'org-superstar)
;;                   (setq-local -org-superstar-headline-bullets-list org-superstar-headline-bullets-list
;;                               ;; org-superstar-headline-bullets-list '("🙐" "🙑" "🙒" "🙓" "🙔" "🙕" "🙖" "🙗")
;;                               org-superstar-headline-bullets-list '("🙘" "🙙" "🙚" "🙛")
;;                               -org-superstar-remove-leading-stars org-superstar-remove-leading-stars
;;                               org-superstar-remove-leading-stars t)
;;                   (org-superstar-restart)))))
;;   (add-hook 'writeroom-mode-disable-hook
;;             (defun +zen-dirty-org ()
;;               (when (eq major-mode 'org-mode)
;;                 (setq-local display-line-numbers -display-line-numbers)
;;                 (when -org-indent-mode
;;                   (org-indent-mode 1))
;;                 (when (featurep 'org-superstar)
;;                   (setq-local org-superstar-headline-bullets-list -org-superstar-headline-bullets-list
;;                               org-superstar-remove-leading-stars -org-superstar-remove-leading-stars)
;;                   (org-superstar-restart))))))


; ;; ----------------------------------------------------------------------------
; ;; Ivy
; ;; ----------------------------------------------------------------------------

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(setq ivy-read-action-function #'ivy-hydra-read-action)
(setq ivy-sort-max-size 50000)

;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)

; ;; ----------------------------------------------------------------------------
; ;; IDO
; ;; ----------------------------------------------------------------------------

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)


; ;; ----------------------------------------------------------------------------
; ;; Package.el
; ;; ----------------------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-snipe writeroom-mode evil-escape org-bullets org-journal org-roam company restclient ivy-yasnippet format-all projectile lsp-ivy lsp-mode eglot evil-leader emmet-mode web-mode tide rjsx-mode js2-mode evil-nerd-commenter treemacs neotree ranger ivy-prescient prescient centaur-tabs counsel ibuffer-sidebar swiper-helm ivy-fuz hlinum dired-ranger one-themes helm swiper)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


; ;; ----------------------------------------------------------------------------
; ;; Starting Modes
; ;; ----------------------------------------------------------------------------

(ivy-prescient-mode 1)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(projectile-mode 1)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


; ;; ----------------------------------------------------------------------------
; ;; evil-keybinds
; ;; ----------------------------------------------------------------------------

(require 'evil-leader)
(evil-leader/set-key
  "i" 'ibuffer
  "RET" 'execute-extended-command
  "<SPC>" 'dired
;;  "p" 'projectile-command-map
  "b" 'switch-to-buffer
  "." 'find-file
  "l" 'lsp
  "wl" 'evil-window-right
  "wh" 'evil-window-left
  "wk" 'evil-window-up
  "wj" 'evil-window-down
  "ws" 'evil-window-split
  "wv" 'evil-window-vsplit
  )

(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)


; ;; ----------------------------------------------------------------------------
; ;; evil-mode
; ;; ----------------------------------------------------------------------------

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(evil-escape-mode 1)

