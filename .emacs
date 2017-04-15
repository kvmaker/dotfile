;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; .emacs --- kvmaker's own emacs config file                                 ;;
;; Copyright (C) 2013, 2014 kvmaker                                           ;;
;; Author:   <kvmaker@gmail.com>                                              ;;
;; Created:  2015/05/23                                                       ;;
;; Update:   2017/04/15 remove uncessary part.                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            PKG                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load path
(add-to-list 'load-path "~/.emacs.d/my")
(add-to-list 'load-path "~/.emacs.d/3rd")

;; misc config
(setq make-backup-files nil)
;;(global-linum-mode t)
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
(setq-default fill-column 79)
;;(add-hook 'after-change-major-mode-hook 'fci-mode)

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
(setq ac-ignore-case nil)
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
                    :foreground "DarkRed"
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
    ((eq major-mode 'c++-mode) "c++")
	((eq major-mode 'org-mode) "org")
	((eq major-mode 'makefile-mode) "makefile")
    ((eq major-mode 'python-mode) "python")
    ((eq major-mode 'ruby-mode) "ruby")
    ((eq major-mode 'haskell-mode) "haskell")
    (t "User Buffer"))))

;; rename dup buffer
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)

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

;; encode
;; UTF-8 settings 
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8) 
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system
	  '(utf-8 . utf-8))
(setq default-buffer-file-coding-system 'utf-8)

;; function-args
(add-to-list 'load-path "~/.emacs.d/3rd/function-args")
(require 'function-args)
(fa-config-default)

;; custom-set-variable
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(semantic-c-dependency-system-include-path (quote ("/usr/include" "/usr/include/c++/4.6.3" ".")))
 '(session-use-package t nil (session))
 '(tabbar-mode t nil (tabbar))
 '(tabbar-mwheel-mode t nil (tabbar))
 '(tabbar-separator (quote (2.0)))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(url-cookie-file "/home/yubo/.emacs.d/url/cookies")
 '(url-history-file "/home/yubo/.emacs.d/url/history")
 '(url-show-status nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-comment ((t (:background "gray85" :slant normal))))
 '(rfcview-headlink-face ((t (:foreground "blue"))))
 '(rfcview-headname-face ((t (:underline (:color "blue" :style wave) :weight bold)))))

;;Quick key
(global-set-key (kbd "C-q") 'set-mark-command)
(global-set-key (kbd "C-t") 'copy-region-as-kill)
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-c d s") 'desktop-save-mode)
(global-set-key (kbd "M-/")   'hippie-expand)
(global-set-key (kbd "M-p")  'fa-show)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               MODE                                         ;;
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
			 (fci-mode t)
			 (semantic-mode t)
			 (semantic-idle-summary-mode)
			 (abbrev-mode -1)))

(add-hook 'c++-mode-hook
		  '(lambda()
			 (c-set-style "k&r")
			 (setq c-basic-offset 4)
			 (setq indent-tabs-mode nil)
			 (setq ac-sources (append '(ac-source-semantic)  ac-sources))
			 (linum-mode t)
			 (fci-mode t)
			 (semantic-mode t)
			 (semantic-idle-summary-mode)
			 (abbrev-mode -1)))

;; makefile mode
(add-to-list 'auto-mode-alist '("\\.hsan\\'" . makefile-mode))
(add-hook 'makefile-mode
		  '(lambda ()
			 (setq indent-tabs-mode nil)))

;; rfc-mode
(setq auto-mode-alist
	  (cons '("/rfc[0-9]+\\.txt\\(\\.gz\\)?\\'" . rfcview-mode)
			auto-mode-alist))
(autoload 'rfcview-mode "rfcview" nil t)

;; python-mode
(add-hook 'python-mode-hook
		  '(lambda()
			 (linum-mode t)
			 (fci-mode t)))

(desktop-read)
