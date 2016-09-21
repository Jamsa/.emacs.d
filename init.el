;; 添加/usr/local/bin至PATH
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/local/bin") exec-path ))
(setenv "ORACLE_HOME" "/opt/oracle")
(setenv "DYLD_LIBRARY_PATH" (concat "/opt/oracle:" (getenv "DYLD_LIBRARY_PATH")))
(setenv "PATH" (concat "/opt/oracle:" (getenv "PATH")))
(setq exec-path (append '("/opt/oracle") exec-path ))
(setenv "NLS_LANG" "SIMPLIFIED CHINESE_CHINA.UTF8")

;; shift-space 
(global-set-key [?\S- ] 'set-mark-command)

(setq tab-width 4)
(setq-default indent-tabs-mode nil)

(server-start)

;; package系统
(require 'package)
(add-to-list 'package-archives '("marmalade"
				 . "http://marmalade-repo.org/packages/")) ;包数量更多
(add-to-list 'package-archives '("melpa"
				 . "http://melpa.milkbox.net/packages/")) ;有大多数的包，每日更新
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/")) ;elpy环境
(package-initialize)

(defvar my-packages
  '(web-mode
    yasnippet
    session
    auto-complete
    scala-mode2
    js2-mode
    helm
    helm-projectile
    markdown-mode
    htmlize
    ))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; smex
;;(require 'smex)
;;(global-set-key (kbd "M-x") 'smex)

;helm-mode
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files) ;不能直接访问当前的目录
;(global-set-key (kbd "C-x C-f") 'menu-find-file-existing)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-y") 'helm-show-kill-ring) ;剪贴板历史

(setq helm-ff-file-name-history-use-recentf t ;显示历史记录
      helm-buffers-fuzzy-matching t      ;模糊匹配名称
      helm-split-window-in-side-p nil    ;在当前窗口内打开helm mini buffer
      helm-autoresize-mode t)

;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; 用tab代替C-j选中
;(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; 在终端下使用C-i
;(define-key helm-map (kbd "C-j")  'helm-select-action) ; 使用C-j显示Action列表
(define-key helm-map (kbd "S-SPC")      'helm-toggle-visible-mark)


;; projectle
(projectile-global-mode)
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(helm-projectile-on) ;依赖于ack，mac上需要brew install ack

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))

; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.htm\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
                                        ;(setq web-mode-markup-indent-offset 2)

(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-indent-style 4)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js-indent-level 2)
(setq js2-basic-offset 2)

;; auto complete
(require 'auto-complete)
;(require 'go-autocomplete)
(require 'auto-complete-config)
;(require 'go-mode-load)
(global-auto-complete-mode t)
;(setq ac-auto-show-menu 0.8)
;(setq ac-delay 0.1)
(ac-config-default)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(yas-minor-mode-on)
;(yas-load-directory (concat lib-path "/yasnippet/snippets"))
;(global-set-key "\C-cay" 'yas-insert-snippet)

;; org-mode
(require 'ox-html)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(setq org-export-html-coding-system 'utf-8-unix)
(setq org-html-viewport nil)
(setq org-publish-project-alist
      '(
        ;; ... add all the components here (see below)...
        ("blog-notes"
         :base-directory "~/Documents/devel/docs/org/notes/" ;org文件的目录
         :base-extension "org" ;扩展名
         :publishing-directory "~/Documents/devel/docs/org/notes_html/" ;导出目录
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :section-numbers nil
         :author "zhujie"
         :email "jamsa at gmail dot com"
         :auto-sitemap t                ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "站点地图"         ; ... with title 'Sitemap'.
         :sitemap-sort-files anti-chronologically
         :sitemap-file-entry-format "%d [%t]"
         ;:html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://orgmode.org/worg/style/worg.css\"/>"
         :html-postamble nil            ;不产生底部明细信息
         :html-head-include-default-style nil ;不在html内生成默认的样式内容
         :html-validation-link nil            ;去掉valiation显示
         :html-link-home "index.html"
         :html-link-up "sitemap.html"
         )
        ("blog-static"
         :base-directory "~/Documents/devel/docs/org/notes/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Documents/devel/docs/org/notes_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("blog" :components ("blog-notes","blog-static"))
        ))


;; 其它设置
(desktop-save-mode t)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; theme
(load-theme 'wombat t)


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

;; 全局设置
;; 字体
;(set-default-font "YaHei Consolas Hybrid-12")
;(set-frame-font "Consolas-11")
;(set-fontset-font "fontset-default" 'han '("Microsoft YaHei" . "unicode-bmp"))

;(print (font-family-list))显示所有字体
(set-default-font "Monaco 14")          ;默认字体和字号
(set-fontset-font "fontset-default" 'han '("STHeiti")) ;中文字体
(setq face-font-rescale-alist '(("STHeiti" . 1.2)))    ;中文字体缩放，处理中英文等宽问题

;; 高亮当前行
;(global-hl-line-mode 1)
;; 禁止产生备份
(setq make-backup-files nil)
;; 关闭Emacs启动时提示信息
(setq inhibit-startup-message t)
;; 启动语法高亮
(global-font-lock-mode't)
;; 关闭按TAB时发出的嘀嘀声,mac中开启后窗口中间出现黑框
(setq visible-bell nil)
;; 关闭提示音
(setq ring-bell-function 'ignore)
;; 显示时间
(display-time)
;; 显示列号
(column-number-mode t)
;; 显示匹配的括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;; 高亮选区
;(transient-mark-mode t)
;; 用y/n代替yes/no
(fset'yes-or-no-p 'y-or-n-p)
;; 关闭工具条
(tool-bar-mode 0)
;; 不显示滚动条
(scroll-bar-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(display-time-mode t)
 '(markdown-command
   "pandoc -s --include-in-header=/Users/zhujie/Documents/devel/docs/markdown/src/pandoc.header -c http://johnmacfarlane.net/pandoc/demo/pandoc.css")
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
