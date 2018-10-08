;; 环境变量
(when *is-a-mac*
  ;; 添加/usr/local/bin至PATH
  (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
  (setq exec-path (append '("/usr/local/bin") exec-path )))

(provide 'init-exec-path)
