(require 'cl-lib)
(require 'company)
;; sqlplus mode的 buffer local变量中保存了数据库的元数据，可以从中获取补全变量

;不需要保存了，可以直接获取(car (sqlplus-get-objects-alist sqlplus-connect-string)),取所有表(alist-get 'table (sqlplus-get-objects-alist sqlplus-connect-string))
;(get-buffer (sqlplus-get-process-buffer-name sqlplus-connect-string))
;(mapcar (lambda (row) (message (car row))) (alist-get `table  (sqlplus-get-objects-alist sqlplus-connect-string)))


(defun company-sqlplus (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-sqlplus-backend))
    (prefix (and (eq major-mode 'sqlplus-mode)
                  (company-grab-symbol)))
     (candidates
      (cl-remove-if-not
       (lambda (c) (string-prefix-p arg c))
       (mapcar (lambda (row) (car row)) (alist-get `table  (sqlplus-get-objects-alist sqlplus-connect-string)))
       ))))

;; 不需要使用advice来拦截数据了

;; (defvar company-sqlplus-symbols nil
;;   "数据库元数据，存储在sqlplus每个连接对应的process buffer变量中")
;; (make-variable-buffer-local 'company-sqlplus-symbols)

;; (defun company-sqlplus-my-handler-advice (connect-string table-data)
;;   (setq company-sqlplus-symbols (sqlplus-prepare-update-alist table-data))
;;   (message (prin1-to-string company-sqlplus-symbols)))

;; (when (featurep 'sqlplus)
;;   (advice-remove 'sqlplus-my-handler #'company-sqlplus-my-handler-advice)
;;   (advice-add 'sqlplus-my-handler :before #'company-sqlplus-my-handler-advice))
