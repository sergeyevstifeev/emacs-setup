;; Load path
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
(add-to-list 'load-path "~/.emacs.d/plugins/expand-region")
(add-to-list 'load-path "~/.emacs.d/plugins/drag-stuff")
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-color-theme-solarized")
(add-to-list 'load-path "~/.emacs.d/plugins/edts")
(add-to-list 'load-path ".emacs.d/plugins/mo-git-blame")

;; Auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/ac-dict")
(add-to-list 'ac-modes 'erlang-mode)
(ac-config-default)
(setq ac-auto-start 10)
(setq ac-delay 0.1)
(define-key ac-mode-map (kbd "M-c") 'auto-complete)
(ac-set-trigger-key "TAB")
(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map "\r" nil)

;; Erlang Mode
(setq load-path (cons  "~/Apps/OTP/install/R14B03/lib/erlang/lib/tools-2.6.6.4/emacs" load-path))
(setq erlang-root-dir "~/Apps/OTP/install/R14B03/lib/erlang")
(setq exec-path (cons "~/Apps/OTP/install/R14B03/lib/erlang/bin" exec-path))
(require 'erlang-start)

(autoload 'erlang-mode "erlang.el" "" t)
(add-to-list 'auto-mode-alist '("
\\
.[eh]rl$" . erlang-mode))

(add-to-list 'auto-mode-alist '("
\\
.yaws$" . erlang-mode))


;; Git support
(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)
(add-to-list 'vc-handled-backends 'Git)
(global-set-key "\C-x\ v\ b" 'mo-git-blame-current)


;; ido setup
(require 'ido)
(ido-mode t)
;;(require 'ido-better-flex)
;;(ido-better-flex/enable)


(require 'ewoc)


;; flymake setup
;; (require 'flymake)
;; (defun flymake-erlang-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;             'flymake-create-temp-inplace))
;;           (local-file (file-relative-name temp-file
;;           (file-name-directory buffer-file-name))))
;;     (list "~/.emacs.d/plugins/eflymake.erl" (list local-file))))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-erlang-init))
;; (add-hook 'erlang-mode-hook 'flymake-mode)


;; Don't wrap long lines
(setq-default truncate-lines t)


(require 'drag-stuff)
(drag-stuff-global-mode t)


(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


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


;; EDTS setup
(require 'edts-start)

(setq edts-projects
      '(( ;; dev
         (name       . "dev")
         (root       . "~/dev")
         (node-sname . "kred"))))

(global-set-key "\C-c\C-dR" 'edts-refactor-extract-function)


;; Underline erlang exported functions
(set-face-attribute 'erlang-font-lock-exported-function-name-face nil
                    :underline t)

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
(setq column-number-mode t)
;; no tabs by default. modes that really need tabs should enable
;; indent-tabs-mode explicitly. makefile-mode already does that, for
;; example.
(setq-default indent-tabs-mode nil)


;; toogle-fullscreen is intrusive, not allowing ubuntu 'notify-send' command output
;; to be seen. Disabled for now.
;; (defun toggle-fullscreen (&optional f)
;;   (interactive)
;;   (let ((current-value (frame-parameter nil 'fullscreen)))
;;     (set-frame-parameter nil 'fullscreen
;;                          (if (equal 'fullboth current-value)
;;                              (if (boundp 'old-fullscreen) old-fullscreen nil)
;;                            (progn (setq old-fullscreen current-value)
;;                                   'fullboth)))))
;;    (global-set-key [M-f11] 'toggle-fullscreen)

;; Make new frames fullscreen by default. Note: this hook doesn't do
;; anything to the initial frame if it's in your .emacs, since that file is
;; read _after_ the initial frame is created.
;;(add-hook 'after-make-frame-functions 'toggle-fullscreen)


(setq visible-bell t)


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))
(global-set-key (kbd "\C-u") 'duplicate-line)

;; Show recently edited files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


;; Auto-pairing brackets
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers
(setq autopair-blink nil)


;; Yasnippet setup
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(setq yas/indent-line 'auto)


;; Automatically indent when adding a newline
(add-hook 'erlang-mode-hook '(lambda ()
                               (local-set-key (kbd "RET") 'newline-and-indent)))


;; Automatically indent pasted lines
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


;; Fonts, etc.
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
 ;;'(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :family "apple-monaco"))))
 '(my-long-line-face ((((class color)) (:background "#FFC125"))) t))


;; Color theme (solarized)
(require 'color-theme)
(autoload 'color-theme-solarized-light "color-theme-solarized.el" "" t)
(autoload 'color-theme-solarized-dark "color-theme-solarized.el" "" t)
(setq color-theme-is-global t)
(color-theme-solarized-light)


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
(set-face-attribute 'default nil :font "-*-Monaco-normal-r-*-*-17-*-*-*-c-*-iso8859-1")

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
