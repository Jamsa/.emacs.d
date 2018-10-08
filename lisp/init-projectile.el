;; projectle
(require 'projectile)
(projectile-global-mode)
;;(setq projectile-indexing-method 'native) emacs实现的索引方式，比较慢
(setq projectile-indexing-method 'alien) ;使用外部工具find svn git等进行索引
(setq projectile-enable-caching t)

(setq projectile-completion-system 'helm)
(helm-projectile-on) ;依赖于ack，mac上需要brew install ack
;; helm projectle ack grep等操作时忽略的文件和目录
(add-to-list 'projectile-globally-ignored-files "*.~undo-tree~")
(add-to-list 'projectile-globally-ignored-files "*.DS_Store")
(add-to-list 'projectile-globally-ignored-directories "node_modules")
(add-to-list 'projectile-globally-ignored-directories "build")
(add-to-list 'projectile-globally-ignored-directories "classes")
(add-to-list 'projectile-globally-ignored-directories ".git")
(add-to-list 'projectile-globally-ignored-directories ".svn")
(add-to-list 'projectile-globally-ignored-directories ".idea")
(add-to-list 'projectile-globally-ignored-directories ".gradle")

(provide 'init-projectile)
