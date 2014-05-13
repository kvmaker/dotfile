;; home path
(if (eq system-type 'windows-nt)
	(progn
	  (setenv "HOME" "d:/home")
	  (setenv "PATH" "d:/home")
	  (setq default-directory "~/")
	  (set-face-attribute 'default nil :font "Consolas 11")
	  (set-fontset-font (frame-parameter nil 'font)
                  'han (font-spec :family "Microsoft Yahei"
                                  :size 16))))

;; load path
(add-to-list 'load-path "~/.emacs.d/my")
(add-to-list 'load-path "~/.emacs.d/3rd")

;; misc set
(setq make-backup-files nil)
(global-linum-mode t)
(setq linum-format "%4d ")
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq tab-width 4)
(setq user-full-name "Yu Bo")
(setq user-mail-address "kvmaker.yubo@huawei.com")
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(icomplete-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(setq resize-mini-windows t)
(setq suggest-key-bindings t)
(put 'dired-find-alternate-file 'disabled nil)
(setq frame-title-format "May the Force be with you!")
(display-time-mode 1)
(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))
(add-hook 'eshell-mode-hook   '(lambda () (linum-mode -1)))
(add-hook 'cscope-mode-hook   '(lambda () (linum-mode -1)))


;;C/C++-Mode
(setq default-tab-width 4)
(add-hook 'c-mode-hook
		  '(lambda()
			 (c-set-style "k&r")
			 (setq c-basic-offset 4)
			 (setq indent-tabs-mode nil)))

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

;; desktop
(require 'desktop)
(desktop-load-default)
(desktop-read)

;; session
(require 'session)
(add-hook 'after-init-hook
          'session-initialize)

;; fill-column
(require 'fill-column-indicator)
(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'makefile-mode-hook 'fci-mode)
(setq-default fill-column 79)

;; color
(require 'color-theme)
(color-theme-blue-mood)

;; putty
(require 'putty)
(putty-hack)

;; hsan
(require 'hsan)

;; cscope 
(require 'xcscope)

;; CC-mode
(add-hook 'c-mode-hook '(lambda ()
						  (setq ac-sources (append '(ac-source-semantic)  ac-sources))
						  (linum-mode t)
						  (semantic-mode t)
						  (semantic-idle-summary-mode)))

;; yasnapt
(add-to-list 'load-path "~/.emacs.d/3rd/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/3rd/yasnippet/yasmate"
						 "~/.emacs.d/my/yas"))
(yas-global-mode 1)
(add-hook 'c-mode-hook '(lambda () (yas-minor-mode)))
(defalias 'yas/current-snippet-table 'yas--get-snippet-tables)
(yas/minor-mode-on)
(setq yas/prompt-functions
      '(yas/dropdown-prompt 
		yas/x-prompt
		yas/completing-prompt
		yas/ido-prompt 
		yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on)

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

;; haskell-mode
(add-to-list 'load-path "~/.emacs.d/3rd/haskell-mode/")
;;(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/.emacs.d/3rd/haskell-mode/")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;;Quick key
(global-set-key (kbd "C-q") 'set-mark-command)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-name "left9")
 '(ecb-methods-menu-sorter nil)
 '(ecb-options-version "2.40")
 '(ecb-show-tags (quote ((default (include collapsed nil) (parent collapsed nil) (type flattened nil) (variable collapsed nil) (function flattened nil) (label hidden nil) (t collapsed nil)) (c++-mode (include collapsed nil) (parent collapsed nil) (type flattened nil) (variable collapsed nil) (function flattened nil) (function collapsed nil) (label hidden nil) (t collapsed nil)) (c-mode (include collapsed nil) (parent collapsed nil) (type flattened nil) (variable collapsed nil) (function flattened nil) (function collapsed nil) (label hidden nil) (t collapsed nil)) (bovine-grammar-mode (keyword collapsed name) (token collapsed name) (nonterminal flattened name) (rule flattened name) (t collapsed nil)) (wisent-grammar-mode (keyword collapsed name) (token collapsed name) (nonterminal flattened name) (rule flattened name) (t collapsed nil)) (texinfo-mode (section flattened nil) (def collapsed name) (t collapsed nil)))))
 '(ecb-tag-display-function (quote ((default . ecb-format-tag-name))))
 '(org-agenda-files (quote ("~/work/org/ffwd.org" "~/work/org/ssf.org")))
 '(semantic-c-dependency-system-include-path (quote ("/usr/include" "." "./include" "../include" "~/v2r9/build/include")))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; rename dup buffer
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; high light current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(set-face-foreground 'highlight nil)

;; org-mod
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(put 'set-goal-column 'disabled nil)

;; scala-mod
(add-to-list 'load-path "~/.emacs.d/3rd/scala/")
(require 'scala-mode-auto)

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)

;; chinese code
(set-language-environment 'Chinese-GB)
(setq-default pathname-coding-system 'euc-cn)
(setq file-name-coding-system 'euc-cn)

;; ecb
(add-to-list 'load-path "~/.emacs.d/3rd/ecb")
(require 'ecb)
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil)
(semantic-mode 1)

;; emacs-server
;; 1) use emacsclient xxx
;; 2) usr C-x # to end edit
;;(server-start)
