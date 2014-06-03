(require 'json)

(defun get-current-word ()
  "Get the word to translate."
  (save-excursion
    (when (not mark-active)
      (forward-word)
      (backward-word)
      (mark-word))
    (buffer-substring
     (region-beginning)
     (region-end))))

(defun get-json (url)
  (let ((buffer (url-retrieve-synchronously url))
        (json nil))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
	  (recode-region (point) (point-max) 'utf-8 ')
      (setq json (buffer-substring-no-properties (point) (point-max)))
      (kill-buffer (current-buffer)))
    json))

(defun get-and-parse-json (url)
  (let ((json-object-type 'plist))
    (json-read-from-string 
     (decode-coding-string (get-json url) 'utf-8))))

(defun translate0 (word)
  (plist-get (plist-get (get-and-parse-json 
						 (concat "http://fanyi.youdao.com/openapi.do?keyfrom=JustDoDDD&key=486401619&type=data&doctype=json&version=1.1&q=" word))
						:basic)
			 :explains))

(defun translate1 (trans)
  (let ((res nil))
	(mapcar (lambda (exp) 
			  (setq res (concat res (concat exp "\n"))))
			trans)
	res))

(defun translate ()
  (interactive)
  (let ((word (get-current-word)))
	(popup-tip (translate1 (translate0 word)))))

