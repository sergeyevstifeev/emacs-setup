(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-color-theme-solarized")

;; Auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/ac-dict")
(ac-config-default)
(setq ac-auto-start 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; erlang
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Erlang Mode
;;(setq load-path (cons  "/Users/sergey/git/klarna/R14B03/install/lib/erlang/lib/tools-2.6.5.1/emacs" load-path))
(setq load-path (cons  "~/git/klarna/OTP/install/R14B03/lib/erlang/lib/tools-2.6.6.4/emacs" load-path))
;;(setq erlang-root-dir "/Users/sergey/git/klarna/OTP/install/R13B04/lib/erlang")
(setq erlang-root-dir "~/git/klarna/OTP/install/R14B03/lib/erlang")
;;(setq exec-path (cons "/Users/sergey/git/klarna/OTP/install/R13B04/lib/erlang/bin" exec-path))
(setq exec-path (cons "~/git/klarna/OTP/install/R14B03/lib/erlang/bin" exec-path))
(require 'erlang-start)

(autoload 'erlang-mode "erlang.el" "" t)
(add-to-list 'auto-mode-alist '("
\\
.[eh]rl$" . erlang-mode))
;; This is needed for Distel setup
;;(let ((distel-dir "~/Apps/distel/elisp"))
;;  (unless (member distel-dir load-path)
;;    ;; Add distel-dir to the end of load-path
;;    (setq load-path (append load-path (list distel-dir)))))

(add-to-list 'auto-mode-alist '("
\\
.yaws$" . erlang-mode))
(add-to-list 'load-path "~/Apps/distel/elisp/")
(require 'distel)
(distel-setup)
(setq erl-nodename-cache 'kred@pike)

;; -----------------------------------------------------------------------------
;; Git support
;; -----------------------------------------------------------------------------
(require 'git)
(load "/usr/share/doc/git-core/contrib/emacs/git.el")
(load "/usr/share/doc/git-core/contrib/emacs/git-blame.el")
(add-to-list 'vc-handled-backends 'Git)


(require 'ido)
(ido-mode t)
;;(require 'ido-better-flex)
;;(ido-better-flex/enable)

(require 'ewoc)

(require 'flymake)
(defun flymake-erlang-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
            'flymake-create-temp-inplace))
          (local-file (file-relative-name temp-file
          (file-name-directory buffer-file-name))))
    (list "~/.emacs.d/plugins/eflymake.erl" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-erlang-init))

(add-hook 'erlang-mode-hook 'flymake-mode)
(add-hook 'erlang-mode-hook 'auto-complete-mode)

;; ack-grep search
(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-samee "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)


;; Scroll between buffers
(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(defun next-emacs-buffer ()
  "Switch to the next emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(global-set-key (kbd "<f5>") 'find-file) ; Open file or dir
(global-set-key (kbd "<f6>") 'kill-this-buffer) ; Close file

(global-set-key (kbd "<C-prior>") 'previous-user-buffer) ; Ctrl+PageUp
(global-set-key (kbd "<C-next>") 'next-user-buffer) ; Ctrl+PageDown
(global-set-key (kbd "<C-S-prior>") 'previous-emacs-buffer) ; Ctrl+Shift+PageUp
(global-set-key (kbd "<C-S-next>") 'next-emacs-buffer) ; Ctrl+Shift+PageDown


;; Prefer backward-kill-word over Backspace
;;(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


(defalias 'qrr 'query-replace-regexp)


;; Recursively fuzzy-search for file in project
(require 'find-file-in-project)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)


(global-set-key [f8] 'recompile)


;; disable vc-git
;;(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))
;;(setq vc-handled-backends ())

;; mo-git-blame
;;(autoload 'mo-git-blame-file "mo-git-blame" nil t)
;;(autoload 'mo-git-blame-current "mo-git-blame" nil t)
;;(setq mo-git-blame-blame-window-width 25)
;;(global-set-key [?\C-b] 'mo-git-blame-current)
;;(global-set-key [?\C-c ?f] 'mo-git-blame-file)

;;(add-hook 'erlang-mode-hook 'flymake-mode)

;;(setq ctrl-z-map (make-keymap))
;;(global-set-key "\C-z" ctrl-z-map)
;;(global-set-key "\C-zd" 'flymake-display-err-menu-for-current-line)
;;(global-set-key "\C-zn" 'flymake-goto-next-error)
;;(global-set-key "\C-zp" 'flymake-goto-prev-error)

;;; Erlang hook
(defun my-erlang-mode-hook ()
 ;; Set default encodings
 (set-terminal-coding-system 'iso-8859-1)
 (set-keyboard-coding-system 'iso-8859-1)
 (setq default-buffer-file-coding-system 'iso-8859-1)
 (prefer-coding-system 'iso-8859-1)
 (set-language-environment "Latin-1")
 (setq file-buffer-coding 'iso-8859-1)
 (let ((mode (current-input-mode)))
   (setcar (cdr (cdr mode)) 8)
   (apply 'set-input-mode mode))
 (setq indent-tabs-mode nil)
 (custom-set-faces
;;  '(my-tab-face            ((((class color)) (:background "#3f2020"))) t)
;;  '(my-trailing-space-face ((((class color)) (:background "#3f2020"))) t)
  '(my-long-line-face ((((class color)) (:background "#FFC125"))) t))
 (font-lock-add-keywords
  'erlang-mode
  '(("\t+" (0 'my-tab-face t))
    ("^.\\{81,\\}$" (0 'my-long-line-face t))
    ("[ \t]+$"      (0 'my-trailing-space-face t))))
)
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)


(delete-selection-mode 1)
;;(setq erlang-indent-level 2)
(setq column-number-mode t)

 ;; no tabs by default. modes that really need tabs should enable
 ;; indent-tabs-mode explicitly. makefile-mode already does that, for
 ;; example.
 (setq-default indent-tabs-mode nil)

 ;; if indent-tabs-mode is off, untabify before saving
 ;;(add-hook 'write-file-hooks 
 ;;         (lambda () (if (not indent-tabs-mode)
 ;;                        (untabify (point-min) (point-max)))))


    (defun toggle-fullscreen (&optional f)
      (interactive)
      (let ((current-value (frame-parameter nil 'fullscreen)))
           (set-frame-parameter nil 'fullscreen
                                (if (equal 'fullboth current-value)
                                    (if (boundp 'old-fullscreen) old-fullscreen nil)
                                    (progn (setq old-fullscreen current-value)
                                           'fullboth)))))

;;    (global-set-key [M-f11] 'toggle-fullscreen)

    ; Make new frames fullscreen by default. Note: this hook doesn't do
    ; anything to the initial frame if it's in your .emacs, since that file is
    ; read _after_ the initial frame is created.
    (add-hook 'after-make-frame-functions 'toggle-fullscreen)



(setq visible-bell t)



(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "\C-u") 'duplicate-line)

;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


   (require 'autopair)
   (autopair-global-mode) ;; enable autopair in all buffers 
   (setq autopair-blink nil)


    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
    (setq yas/indent-line 'auto) 

    (add-hook 'erlang-mode-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))



;; auto-indent pasted lines
(dolist (command '(yank yank-pop))
       (eval `(defadvice ,command (after indent-region activate)
                (and (not current-prefix-arg)
                     (member major-mode '(emacs-lisp-mode lisp-mode
                                                          clojure-mode    scheme-mode
                                                          haskell-mode    ruby-mode
                                                          rspec-mode      python-mode
                                                          c-mode          c++-mode
                                                          objc-mode       latex-mode
                                                          plain-tex-mode  erlang-mode))
                     (let ((mark-even-if-inactive transient-mark-mode))
                       (indent-region (region-beginning) (region-end) nil))))))

;; turn off scrollbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; turn off toolbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;; turn off menubar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(safe-local-variable-values (quote ((allout-layout . t) (erlang-indent-level . 4) (erlang-indent-level . 2)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :family "apple-monaco"))))
 '(my-long-line-face ((((class color)) (:background "#FFC125"))) t))


;; Color theme
(require 'color-theme)
(autoload 'color-theme-solarized-light "color-theme-solarized.el" "" t)
(autoload 'color-theme-solarized-dark "color-theme-solarized.el" "" t)
(setq color-theme-is-global t)
;;(color-theme-gnome2)
;;(color-theme-solarized-dark)
(color-theme-solarized-light)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Language environment
(set-terminal-coding-system 'iso-8859-1)
(setq default-buffer-file-coding-system 'iso-8859-1)
(prefer-coding-system 'iso-8859-1)
(set-language-environment "Latin-1")
(setq file-buffer-coding 'iso-8859-1)
;; (let ((mode (current-input-mode)))
;;   (setcar (cdr (cdr mode)) 8)
;;   (apply 'set-input-mode mode))
; (iso-accents-mode) C-x 8 /a -> å
(let ((mode (current-input-mode)))
  (setcar (cdr (cdr mode)) 8)
  (apply 'set-input-mode mode))

(set-face-font 'default "fixed")
;;(set-face-attribute 'default nil :font "-outline-Courier New-normal-normal-normal-mono-*-*-*-*-c-*-iso8859-1")
;;(set-face-attribute 'default nil :font "-*-Monaco-normal-r-*-*-17-102-120-120-c-*-iso8859-1")
(set-face-attribute 'default nil :font "-*-Monaco-normal-r-*-*-17-*-*-*-c-*-iso8859-1")
;;(set-face-attribute 'default nil :family "Menlo")

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
