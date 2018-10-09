;; package系统
(require 'package)
;;(add-to-list 'package-archives '("marmalade"
;;				 . "http://marmalade-repo.org/packages/")) ;包数量更多
;;(add-to-list 'package-archives '("melpa"
;;				 . "http://melpa.milkbox.net/packages/")) ;有大多数的包，每日更新
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)


(provide 'init-elpa)
