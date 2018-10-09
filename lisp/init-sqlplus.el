(when *is-a-mac*
  (setenv "ORACLE_HOME" "/opt/oracle")
  (setenv "DYLD_LIBRARY_PATH" (concat "/opt/oracle:" (getenv "DYLD_LIBRARY_PATH")))
  (setenv "PATH" (concat "/opt/oracle:" (getenv "PATH")))
  (setq exec-path (append '("/opt/oracle") exec-path )))

(setenv "NLS_LANG" "SIMPLIFIED CHINESE_CHINA.UTF8")
;; sql 缩进
(eval-after-load "sql"
  '(load-library "sql-indent"))

(provide 'init-sqlplus)
