;;; company-sqlplus.el --- company for sqlplus-mode

;; Author: Jie Zhu <jiemao@gmail.com>
;; Keywords: sqlplus, oracle, company, auto-complete

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Configuration:
;;

;;; Code:

(require 'cl-lib)
(require 'company)
;; sqlplus mode的 buffer local变量中保存了数据库的元数据，可以从中获取补全变量

;不需要保存了，可以直接获取(car (sqlplus-get-objects-alist sqlplus-connect-string)),取所有表(alist-get 'table (sqlplus-get-objects-alist sqlplus-connect-string))
;(get-buffer (sqlplus-get-process-buffer-name sqlplus-connect-string))
;(mapcar (lambda (row) (message (car row))) (alist-get `table  (sqlplus-get-objects-alist sqlplus-connect-string)))


;; (defun company-sqlplus (command &optional arg &rest ignored)
;;   (interactive (list 'interactive))
;;   (cl-case command
;;     (interactive (company-begin-backend 'company-sqlplus))
;;     (prefix (and (eq major-mode 'sqlplus-mode)
;;                  (company-grab-symbol)))
;;     (candidates
;;      (cl-remove-if-not
;;       (lambda (c) (string-prefix-p arg c))
;;       (mapcar (lambda (row) (car row)) (alist-get `table  (sqlplus-get-objects-alist sqlplus-connect-string)))
;;       ))))

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

;; 重写
(defun company-sqlplus--match-regexp (regexp)
  (concat "\\(?:\s\\|\n\\|(\\)*"
          regexp
          "\\(?:\n\\|\s\\|.\\)+"))

;;"\\(?:from\\|,\\)\\(?:\s\\|\n\\)+\\(\[a-zA-Z_0-9\]+\\)\\(?:\s\\|as\\)+cp2"
;;\\(.\\|\n\\|s\\)*\\(?:from\\|,\\)\\(?:\s\\|\n\\)+\\(\[a-zA-Z_0-9\]+\\)\\(?:\s\\|as\\)+
(defconst company-sqlplus--regexp-any ".*\\(?:\n.*\\)*")

(defun company-sqlplus--from-alias-regexp (table-alias)
   (concat company-sqlplus--regexp-any "\\(\s\\|^\\)" "\\(?:from\\|,\\)\\(?:\s\\|\n\\)+\\(\[a-zA-Z_0-9\]+\\)\\(?:\s\\|as\\)+" table-alias))

(defun company-sqlplus--from-name-regexp (table-name)
   (concat "\\(?:from\\|,\\)\\(?:\s\\|\n\\)+\\(" table-name "\\)\\(?:\s\\|as\\)+"))

"\\(?:from\\|,\\)\\(?: \\|
\\)+\\([a-zA-Z_0-9]+\\)\\(?: \\|as\\)+t"

(defun company-sqlplus-looking-back ()
  (interactive (list 'interactive))
  (looking-at (company-sqlplus--from-alias-regexp "CP") 0))



(defcustom company-sqlplus-backward-limit 2048
  "后向搜索光标位置信息的限制."
  :group 'company-sqlplus :type 'integer)

(defun company-sqlplus-backward-min-bound ()
  (max (- (point) company-sqlplus-backward-limit)
       (point-min)))

(defconst company-sqlplus-cursor-content-regexp
  "\s"
  "A regular expression matching input content before cursor.")

;; (defun company-sqlplus--get-items (prefix)
;;   (let* ((limit (company-sqlplus-backward-min-bound))
;;          (bound (save-excursion
;;                   (if (re-search-backward "\\(\s\\)" limit t)
;;                       (point)
;;                     limit)))
;;          (grab-prefix (company-grab "\s\\(.+\\)" 1 bound))
;;          (alias-and-field))
;;     (cond
;;      (grab-prefix
;;       ;;(all-completions prefix demo-data)

;;       (setq alias-and-field (split-string grab-prefix "\\."))
;;       (prin1 (car alias-and-field))
;;       (prin1 (company-sqlplus--from-alias-regexp (car alias-and-field)))
;;       (cond
;;        ((= (list-length alias-and-field) 2)
;;         ;;(append '(("aaa2" "aaa")) (list (list (company-grab "\s\\(.+\\)" 1 bound) "aaaa" ) ) )
;;         (if (looking-at (company-sqlplus--from-alias-regexp (car alias-and-field)) )
;;             (list (list (match-data 1) "alias match"))))
;;        ((= (list-length alias-and-field) 1)
;;         (append '(("aaa1" "aaa")) (list (list (company-grab "\s\\(.+\\)" 1 bound) "aaaa" ) ) )
;;         ;;(if (looking-at (company-sqlplus--from-alias-regexp (car alias-and-field)) )
;;         ;;    (list (list (match-data 1) "alias match")))
;;         )
;;        )
;;      ))))


(defun company-sqlplus--get-items (prefix)
  (let* ((limit (company-sqlplus-backward-min-bound))
         (bound (save-excursion
                  (if (re-search-backward "\\(\s\\)" limit t)
                      (point)
                    limit)))
         (grab-prefix (company-grab "\s\\(.+\\)" 1 bound))
         (alias-and-field))
    (cond
     (grab-prefix
      ;;(all-completions prefix demo-data)

      (setq alias-and-field (split-string grab-prefix "\\."))
      (prin1 (car alias-and-field))
      (prin1 (company-sqlplus--from-alias-regexp (car alias-and-field)))
      (cond
       ((= (list-length alias-and-field) 2)
        ;;(append '(("aaa2" "aaa")) (list (list (company-grab "\s\\(.+\\)" 1 bound) "aaaa" ) ) )
        (if (looking-at (company-sqlplus--from-alias-regexp (car alias-and-field)) )
            (list (list (match-data 1) "alias match"))))
       ((= (list-length alias-and-field) 1)
        (append '(("aaa1" "aaa")) (list (list (company-grab "\s\\(.+\\)" 1 bound) "aaaa" ) ) )
        ;;(if (looking-at (company-sqlplus--from-alias-regexp (car alias-and-field)) )
        ;;    (list (list (match-data 1) "alias match")))
        )
       )
     ))))

(company-grab "from\s\\(.+\\)" 1)

;;"\\(?:\s\\|\n\\|(\\)*\\(?:select\\|update\\|insert\\|delete\\)\\(?:\n\\|\s\\|.\\)+"
;;"\\(?:\s\\|\n\\|(\\)*\\(?:select\\|update\\|insert\\|delete\\)\\(?:.\\|\n\\)*\s\\(.+[^\\(where\\|set)]\\)\s cp"

(defun company-sqlplus--make-candidate (candidate)
  (let ((text (car candidate))
        (meta (cadr candidate)))
    (propertize text 'meta meta)))

(defun company-sqlplus--candidates (items)
  (let (res)
    (dolist (item items)
      (when (or t (string-prefix-p prefix (car item)))
        (push (company-sqlplus--make-candidate item) res)))
    res))


(defun company-sqlplus--candidates-table (prefix)
  (message (concat prefix "zzzzzzzzzzz"))
  (company-sqlplus--candidates (concat '(("aaa" "aaa")) ))) ;(list (list prefix "aaa"))
  ;(company-sqlplus--candidates (sqlplus-hidden-select sqlplus-connect-string "select * from user_tables where rownum<20")))


(defun company-sqlplus--annotation (candidate)
  (format " (%s)" (get-text-property 0 'meta candidate)))

(defun company-sqlplus--meta (candidate)
  (format "This will use %s of %s"
          (get-text-property 0 'meta candidate)
          (substring-no-properties candidate)))
;(company-grab "from\s\\(.+\\)" 1)
;;;###autoload
(defun company-sqlplus (command &optional arg &rest ignored)
  "`company-mode' completion back-end for `sqlplus-mode'."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-sqlplus))
    (prefix (progn (message "aaaaaa") (company-grab "from\s\\(.+\\)" 1 200)))
    ;(prefix (company-grab-symbol-cons "\\.\\|-" 20))
    (candidates
     ;(cond
      ;((company-grab "from\s\\(.+\\)" 1 200)
       (company-sqlplus--candidates-table arg))
     ; )
     )
    (annotation (company-sqlplus--annotation arg))
    (meta (company-sqlplus--meta arg))))

(defvar company-sqlplus-parser-split-regexp "\\(^\\|\n\\|\s\\)?\\(select\\|from\\|where\\|order\\|connect\\|group\\|;\\)\\(^\\|\n\\|\s\\)" "进行sql解析时的正则表达式")

(defun company-sqlplus-parse-sql(args)
  "docstring"
  (interactive "P")
  )

;;"select\\(.\\|\n\\)*?from\\(.\\|\n\\)+?\\(;\\|)\\)"

(provide 'company-sqlplus)
;;; company-sqlplus.el ends here
