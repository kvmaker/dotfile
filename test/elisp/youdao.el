(url-retrieve "http://fanyi.youdao.com/openapi.do?keyfrom=JustDoDDD&key=486401619&type=data&doctype=json&version=1.1&q=HUAWEI"
			  (lambda (status) (switch-to-buffer (current-buffer))))

(require 'json)
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

(popup-tip (decode-coding-string
			(get-json "http://fanyi.youdao.com/openapi.do?keyfrom=JustDoDDD&key=486401619&type=data&doctype=json&version=1.1&q=dog")
			'utf-8))

(defun get-and-parse-json (url)
  (let ((json-object-type 'plist))
    (json-read-from-string 
     (decode-coding-string (get-json url) 'utf-8))))

(get-and-parse-json "http://fanyi.youdao.com/openapi.do?keyfrom=JustDoDDD&key=486401619&type=data&doctype=json&version=1.1&q=dog")

