(defun my-last list
  (if (null list)
	  null
	  (if (null (rest list))
		  list
		  (my-last (rest list)))))