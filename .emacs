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

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
						 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/my")
(add-to-list 'load-path "~/.emacs.d/3rd")

;; proxy config
;; (setq url-proxy-services
;; 	  '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;; 		("http" . "dev-proxy.oa.com:8080")
;; 		("https" . "dev-proxy.oa.com:8080")))

;; misc config
(setq make-backup-files nil)
(setq auto-save-default nil)
(global-linum-mode t)
(setq linum-format "%4d ")
(show-paren-mode 1)
(setq show-paren-delay 1)
(setq tab-width 4)
(setq user-full-name "kvmaker")
(setq user-mail-address "kvmaker@gmail.com")
(setq default-major-mode 'text-mode)
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(icomplete-mode 5)
(fset 'yes-or-no-p 'y-or-n-p)
(setq resize-mini-windows t)
(setq suggest-key-bindings t)

;; cscope 
(require 'xcscope)

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
	((eq major-mode 'makefile-mode) "makefile")
    ((eq major-mode 'python-mode) "python")
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

;; custom-set-variable
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.50")
 '(package-selected-packages
   (quote
	(helm-gtags helm-cscope helm ecb c-eldoc company-math ggtags company)))
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
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white"))))
 '(custom-comment ((t (:background "gray85" :slant normal))))
 '(rfcview-headlink-face ((t (:foreground "blue"))))
 '(rfcview-headname-face ((t (:underline (:color "blue" :style wave) :weight bold)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               MODE                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++-Mode
(setq default-tab-width 4)
(add-hook 'c-mode-hook
		  '(lambda()
			 (c-set-style "k&r")
			 (setq c-basic-offset 4)
;;			 (setq indent-tabs-mode nil)
			 (linum-mode t)
			 (abbrev-mode -1)))

(add-hook 'c++-mode-hook
		  '(lambda()
			 (c-set-style "k&r")
			 (setq c-basic-offset 4)
;;			 (setq indent-tabs-mode nil)
			 (linum-mode t)
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
			 (linum-mode t)))

;; company-mode
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)

;; add in your commonly used packages/include directories here, for
;; example, SDL or OpenGL. this shouldn't slow down cpp, even if
;; you've got a lot of them
(setq c-eldoc-includes "-I/usr/include -I./ -I../ ")
(load "c-eldoc")
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;; helm
(require 'helm-config)

;; helm-gtags
;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
	 (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
	 (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
	 (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
	 (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
	 (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
	 (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
	 (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))
;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
	 (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
	 (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
	 (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
	 (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
	 (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
	 (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
	 (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            QUICK                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Quick key
(global-set-key (kbd "C-q") 'set-mark-command)
(global-set-key (kbd "M-w") 'copy-region-as-kill)
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-c d s") 'desktop-save)
(global-set-key (kbd "M-/") 'company-complete-common)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-z") 'undo)

(desktop-read)
