;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; .emacs --- kvmaker's own emacs config file                                 ;;
;; Copyright (C) 2013, 2014 kvmaker                                           ;;
;; Author:   <kvmaker@gmail.com>                                              ;;
;; Created:  2015/05/23                                                       ;;
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
;;(setq tab-width 4)
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

;; url proxy
(setq url-proxy-services
	  '(("no_proxy" . "^\\(localhost\\|10.*\\)")
		("http" . "proxy.huawei.com:8080")
		("https" . "proxy.huawei.com:8080")))

(setq url-http-proxy-basic-auth-storage
	  (list (list "proxy.huawei.com:8080"
				  (cons "Input your LDAP UID !"
						(base64-encode-string "y00186361:cavendish#2014q2")))))

;; youdao translate
(add-to-list 'load-path "~/.emacs.d/my/youdao")
(require 'youdao)
(setf keyfrom "JustDoDDD")
(setf key     "486401619")
(global-set-key (kbd "C-c t t") 'translate)

;; custom-set-variable
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(org-beamer-frame-default-options "[allowframebreaks=0.8]")
 '(semantic-c-dependency-system-include-path (quote ("/usr/include" ".")))
 '(session-use-package t nil (session))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(url-cookie-file "/home/yubo/.emacs.d/url/cookies")
 '(url-history-file "/home/yubo/.emacs.d/url/history")
 '(url-show-status nil))
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
;; lisp-mode
(add-hook 'lisp-mode-hook
		  '(lambda ()
			 (setq indent-tabs-mode nil)))
(add-hook 'emacs-lisp-mode-hook
		  '(lambda ()
			 (setq indent-tabs-mode nil)))

;; org-mode
(require 'org-install)
(require 'org-latex)
(global-set-key (kbd "C-TAB") 'org-table-previous-field)
(add-hook 'org-mode-hook
		  '(lambda ()
			 (fci-mode t)
			 (linum-mode t)))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(put 'set-goal-column 'disabled nil)
(setq org-ditaa-jar-path "~/.emacs.d/3rd/ditaa/ditaa0_9.jar")
(setq org-completion-use-ido t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)										   
   (emacs-lisp . t)
   (matlab . t)
   (C . t)
   (perl . t)
   (sh . t)
   (ditaa . t)
   (python . t)
   (haskell . t)
   (dot . t)
   (latex . t)
   (js . t)
   ))

(setq org-latex-to-pdf-process
	  '("xelatex -interaction nonstopmode %f"
		"xelatex -interaction nonstopmode %f"))
(setq org-confirm-babel-evaluate nil)
(add-hook 'org-mode-hook
          (lambda ()
            (if (member "REFTEX" org-todo-keywords-1)
                (org-mode-article-modes))))
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("cn-article"
			   "\\documentclass[11pt]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{listings}
\\usepackage{courier}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{latexsym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{fancyvrb}
\\usepackage{xcolor}
\\tolerance=1000
\\usepackage{tikz}
\\usepackage{xeCJK}
\\setmainfont{Times New Roman}
\\setCJKmainfont{SimSun}
\\setCJKsansfont{SimHei}
\\setCJKmonofont{FangSong}
\\tolerance=1000
\\renewcommand{\\figurename}{图}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
			  ("\\section{%s}" . "\\section*{%s}")
			  ("\\subsection{%s}" . "\\subsection*{%s}")
			  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			  ("\\paragraph{%s}" . "\\paragraph*{%s}")
			  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-export-latex-classes
			 '("cn-beamer"
			   "\\documentclass{beamer}
\\usecolortheme[named=FireBrick]{structure}
\\setbeamercovered{transparent}
\\setbeamertemplate{caption}[numbered]
\\setbeamertemplate{blocks}[rounded][shadow=true]
\\setbeamertemplate{frametitle continuation}[from second][\\insertcontinuationcount]
\\usetheme{Darmstadt}
\\usepackage{tikz}
\\usepackage{xeCJK}
\\usepackage{amsmath}
\\setmainfont{Times New Roman}
\\setCJKmainfont{SimSun}
\\setCJKsansfont{SimHei}
\\setCJKmonofont{FangSong}
\\usepackage{verbatim}
\\institute{HUAWEI}
\\graphicspath{{figures/}}
\\definecolor{lstbgcolor}{rgb}{0.9,0.9,0.9}
\\usepackage{listings}
\\usepackage{fancyvrb}
\\usepackage{xcolor}
\\renewcommand{\\figurename}{图}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]
[EXTRA]"
              org-beamer-sectioning))

(setq org-export-latex-listings 'listings)
(setq org-export-latex-listings-options
	  '(
		("frame"           "single")
		("frameround"      "ffff")
		("backgroundcolor" "\\color{yellow!20}")
		("basicstyle"      "\\footnotesize\\ttfamily")
		("breaklines"      "true")
;;		("keywordstyle"    "\\bfseries\\color{green!40!black}")
;;		("commentstyle"    "\\itshape\\color{purple!40!black}")
;;		("identifierstyle" "\\color{blue}")
		("stringstyle"     "\\color{orange}")
		))

;; scala-mode
(add-to-list 'load-path "~/.emacs.d/3rd/scala/")
(require 'scala-mode-auto)

;; Lisp-mode
(add-hook 'lisp-mode-hook 
		  '(lambda()
			 (linum-mode t)
			 (fci-mode t)))
(add-hook 'emacs-lisp-mode-hook 
		  '(lambda()
			 (linum-mode t)
			 (fci-mode t)))

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
