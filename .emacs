;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; .emacs --- kvmaker's own emacs config file                                 ;;
;; Copyright (C) 2013, 2014 kvmaker                                           ;;
;; Author:   <kvmaker@gmail.com>                                              ;;
;; Created:  2015/05/23                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Pakcage                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load path
(add-to-list 'load-path "~/.emacs.d/my")
(add-to-list 'load-path "~/.emacs.d/3rd")

;; misc config
(setq make-backup-files nil)
(global-linum-mode t)
(setq linum-format "%4d ")
(show-paren-mode 1)
(setq show-paren-delay 1)
(setq tab-width 4)
(setq user-full-name "Yu Bo")
(setq user-mail-address "kvmaker.yubo@huawei.com")
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(icomplete-mode 99)
(fset 'yes-or-no-p 'y-or-n-p)
(setq resize-mini-windows t)
(setq suggest-key-bindings t)
(put 'dired-find-alternate-file 'disabled nil)

;; cscope 
(require 'xcscope)

;; fill-column
(require 'fill-column-indicator)
(setq-default fill-column 80)
(add-hook 'after-change-major-mode-hook 'fci-mode)

;; high light current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(set-face-foreground 'highlight nil)

;; yasnapt
(add-to-list 'load-path "~/.emacs.d/3rd/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/3rd/yasnippet/yasmate"
						 "~/.emacs.d/my/yas"))
(defalias 'yas/current-snippet-table 'yas--get-snippet-tables)
(yas/global-mode 1)
(yas/minor-mode-on)

;; popup for yas
(add-to-list 'load-path "~/.emacs.d/3rd/ac")
(require 'popup)
(define-key popup-menu-keymap (kbd "M-n") 'popup-next)
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

(defun yas/popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas/prompt-functions '(yas/popup-isearch-prompt yas/no-prompt))

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/3rd/ac")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (expand-file-name "~/.emacs.d/ac-dict"))
(setq ac-comphist-file (expand-file-name "~/.emacs.d/ac-comphist.dat"))
(ac-config-default)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

;; tabbar
(require 'tabbar)
(tabbar-mode)
(global-set-key [(meta u)] 'tabbar-backward-tab)
(global-set-key [(meta i)] 'tabbar-forward-tab)
(global-set-key [(meta \[)] 'tabbar-backward-group)
(global-set-key [(meta \])] 'tabbar-forward-group)
(set-face-attribute 'tabbar-default nil
					:background "gray80"
					:foreground "gray30"
					:height 1.0)
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "gray30"))
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "DarkGreen"
                    :background "LightGoldenrod"
                    :box '(:line-width 2 :color "DarkGoldenrod")
					:overline "black"
					:underline "black"
                    :weight 'bold)
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "gray70"))
(defun tabbar-buffer-groups ()
"Return the list of group names the current buffer belongs to.
This function is a custom function for tabbar-mode's tabbar-buffer-groups.
This function group all buffers into 3 groups:
Those Dired, those user buffer, and those emacs buffer.
Emacs buffer are those starting with “*”."
  (list
   (cond
    ((string-equal "*" (substring (buffer-name) 0 1)) "Emacs Buffer")
    ((eq major-mode 'c-mode) "c")
	((eq major-mode 'org-mode) "org")
	((eq major-mode 'makefile-mode) "makefile")
    (t "User Buffer"))))

;; slime
(add-to-list 'load-path "~/.emacs.d/3rd/slime")
(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime-autoloads)
(slime-setup '(slime-fancy))

;; rename dup buffer
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)

;; chinese code
;;(set-language-environment 'Chinese-GB)
;;(setq-default pathname-coding-system 'euc-cn)
;;(setq file-name-coding-system 'euc-cn)

;; use italic for comment
(require 'font-lock)
(copy-face 'italic 'font-lock-comment-face)

;; session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; desktop
(load "desktop")
(desktop-load-default) 

;; ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; ido
(require 'ido)
(ido-mode t)

;; custom-set-variable
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(semantic-c-dependency-system-include-path (quote ("/usr/include" ".")))
 '(session-use-package t nil (session))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-comment ((t (:background "gray85" :slant normal)))))

;;Quick key
(global-set-key (kbd "C-q") 'set-mark-command)
(global-set-key (kbd "C-t") 'copy-region-as-kill)
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-c d s") 'desktop-save-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Mode                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++-Mode
(setq default-tab-width 4)
(add-hook 'c-mode-hook
		  '(lambda()
			 (c-set-style "k&r")
			 (setq c-basic-offset 4)
			 (setq indent-tabs-mode nil)
			 (setq ac-sources (append '(ac-source-semantic)  ac-sources))
			 (linum-mode t)
			 (semantic-mode t)
			 (semantic-idle-summary-mode)
			 (abbrev-mode -1)))

(add-hook 'c++-mode-hook
		  '(lambda()
			 (c-set-style "k&r")
			 (setq c-basic-offset 4)
			 (setq indent-tabs-mode nil)))

;; javascript mode
(add-to-list 'auto-mode-alist '("\\.json\\'" . javascript-mode))
(add-hook 'javascript-mode
		  '(lambda ()
			 (setq indent-tabs-mode nil)))

;; makefile mode
(add-to-list 'auto-mode-alist '("\\.hsan\\'" . makefile-mode))
(add-hook 'makefile-mode
		  '(lambda ()
			 (setq indent-tabs-mode nil)))

;; haskell-mode
(add-to-list 'load-path "~/.emacs.d/3rd/haskell-mode/")
(add-to-list 'Info-default-directory-list "~/.emacs.d/3rd/haskell-mode/")
(require 'haskell-mode-autoloads)
(add-hook 'haskell-mode-hook 
		  '(lambda ()
			 (turn-on-haskell-doc-mode)
			 (turn-on-haskell-indent)
			 (turn-on-haskell-simple-indent)))

;; org-mode
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(put 'set-goal-column 'disabled nil)

;; scala-mode
(add-to-list 'load-path "~/.emacs.d/3rd/scala/")
(require 'scala-mode-auto)

;; Lisp-mode
(add-hook 'lisp-mode-hook 
		  '(lambda()
			 (fci-mode t)))
(add-hook 'emacs-lisp-mode-hook 
		  '(lambda()
			 (fci-mode t)))

(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))
(add-hook 'eshell-mode-hook   '(lambda () (linum-mode -1)))
(add-hook 'cscope-mode-hook   '(lambda () (linum-mode -1)))

(desktop-read)
