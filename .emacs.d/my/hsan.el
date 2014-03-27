(defvar user-name "yubo y00186361")
(defun print-c-box ()
  (insert "/***************************************************************************** \n")
  (insert " *                                INCLUDE                                    * \n")
  (insert " *****************************************************************************/\n")
  (insert "\n")
  (insert "/***************************************************************************** \n")
  (insert " *                                LOCAL_DEFINE                               * \n")
  (insert " *****************************************************************************/\n")
  (insert "\n")
  (insert "/***************************************************************************** \n")
  (insert " *                                LOCAL_TYPEDEF                              * \n")
  (insert " *****************************************************************************/\n")
  (insert "\n")
  (insert "/***************************************************************************** \n")
  (insert " *                                LOCAL_VARIABLE                             * \n")
  (insert " *****************************************************************************/\n")
  (insert "\n")
  (insert "/***************************************************************************** \n")
  (insert " *                                LOCAL_FUNCTION                             * \n")
  (insert " *****************************************************************************/\n")
  (insert "\n")
  (insert "/***************************************************************************** \n")
  (insert " *                                PUBLIC_FUNCTION                            * \n")
  (insert " *****************************************************************************/\n")
  (insert "\n")
  (insert "/***************************************************************************** \n")
  (insert " *                                INIT/EXIT                                  * \n")
  (insert " *****************************************************************************/\n"))

(defun print-h-box()
  (let* ((file (buffer-name))
	 (file-len (string-width file))
	 (sfile (substring file 0 (- file-len 2)))
	 (ufile (upcase sfile)))
    (insert "#ifndef __"ufile"_H__\n")
    (insert "#define __"ufile"_H__\n")
    (insert "\n")
    (insert "/***************************************************************************** \n")
    (insert " *                                INCLUDE                                    * \n")
    (insert " *****************************************************************************/\n")
    (insert "\n")
    (insert "#ifdef __cplusplus\n")
    (insert "#if __cplusplus\n")
    (insert "extern \"C\"{\n")
    (insert "#endif\n")
    (insert "#endif /* __cplusplus */\n")
    (insert "\n")
    (insert "/***************************************************************************** \n")
    (insert " *                                DEFINE                                     * \n")
    (insert " *****************************************************************************/\n")
    (insert "\n")
    (insert "/***************************************************************************** \n")
    (insert " *                                TYPEDEF                                    * \n")
    (insert " *****************************************************************************/\n")
    (insert "\n")
    (insert "/***************************************************************************** \n")
    (insert " *                                FUNCTION                                   * \n")
    (insert " *****************************************************************************/\n")
    (insert "\n")
    (insert "#ifdef __cplusplus\n")
    (insert "#if __cplusplus\n")
    (insert "}\n")
    (insert "#endif\n")
    (insert "#endif /* __cplusplus */\n")
    (insert "\n")
    (insert "#endif /* __"ufile"_H__*/\n")
    (insert "\n")))

(defun print-g-head()
  (let ((bufname (buffer-name))
	(time    (current-time-string))
	(desc    (read-string "Description: ")))
    (insert "/******************************************************************************\n")
    (insert "\n")
    (insert "                        Copyright (C), 2012-2013, HSAN                         \n")
    (insert "\n")
    (insert " ******************************************************************************\n")
    (insert "  Filename   : "bufname"\n")
    (insert "  Version    : v1.0 \n")
    (insert "  Author     : "user-name"\n")
    (insert "  Creation   : "time"\n")
    (insert "  Description: "desc"\n")
    (insert " *****************************************************************************/\n")))

(defun print-c-head ()
  (interactive)
  (goto-char (point-min))
  (save-excursion
    (print-g-head)
    (print-c-box)))
  
(defun print-h-head ()
  (interactive)
  (goto-char (point-min))
  (save-excursion
    (print-g-head)
    (print-h-box)))

(defun print-f-head ()
  (interactive)
  (save-excursion
	(insert "/******************************************************************************\n")
	(insert " Function    :\n")
	(insert " Description :\n")
	(insert " Input  Parm :\n")
	(insert " Output Parm :\n")
	(insert " Return      : HI_RET_SUCC/HI_RET_FAIL\n")
	(insert "******************************************************************************/\n")))

(provide 'hsan)