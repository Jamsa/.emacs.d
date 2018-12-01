;;helm-mode
(require 'helm-config)

(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files) ;不能直接访问当前的目录
;;(global-set-key (kbd "C-x C-f") 'menu-find-file-existing)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-y") 'helm-show-kill-ring) ;剪贴板历史

(setq helm-ff-file-name-history-use-recentf t ;显示历史记录
      helm-buffers-fuzzy-matching t      ;模糊匹配名称
      helm-split-window-in-side-p nil    ;在当前窗口内打开helm mini buffer
      helm-autoresize-mode t)

;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; 用tab代替C-j选中
;;(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; 在终端下使用C-i
;;(define-key helm-map (kbd "C-j")  'helm-select-action) ; 使用C-j显示Action列表
(define-key helm-map (kbd "S-SPC")      'helm-toggle-visible-mark)
;;使用mdfind，而不是locate
(setq helm-locate-command "mdfind -name %s %s")

(with-eval-after-load 'projectile
  (setq projectile-completion-system 'helm)
  (helm-projectile-on) ;依赖于ack，mac上需要brew install ack
)

(provide 'init-helm)
