;; 添加/usr/local/bin至PATH
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/local/bin") exec-path ))
(setenv "ORACLE_HOME" "/opt/oracle")
(setenv "DYLD_LIBRARY_PATH" (concat "/opt/oracle:" (getenv "DYLD_LIBRARY_PATH")))
(setenv "PATH" (concat "/opt/oracle:" (getenv "PATH")))
(setq exec-path (append '("/opt/oracle") exec-path ))
(setenv "NLS_LANG" "SIMPLIFIED CHINESE_CHINA.UTF8")
(setenv "TERM" "xterm-256color")

;; package系统
(require 'package)
;(add-to-list 'package-archives '("marmalade"
;				 . "http://marmalade-repo.org/packages/")) ;包数量更多
;(add-to-list 'package-archives '("melpa"
                                        ;				 . "http://melpa.milkbox.net/packages/")) ;有大多数的包，每日更新
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

;; smex
;;(require 'smex)
;;(global-set-key (kbd "M-x") 'smex)

;; buffer切换
(global-set-key (kbd "M-s-<left>") 'previous-buffer)
(global-set-key (kbd "M-s-<right>") 'next-buffer)

;;ace
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "M-z") 'ace-jump-zap-to-char)
(global-set-key (kbd "C-x j") 'ace-jump-word-mode)

;; ido
;(ido-mode nil)

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

;; markdown-mode
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))
(markdown-toggle-math t)                ;启用对mathjax的支持

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
;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
;;(setq web-mode-markup-indent-offset 2)

(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-indent-style 4)

;; emmet
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
(setq js-indent-level 2)
(setq js2-basic-offset 2)
;; jsx会显示错误
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

;; python
;(setq jedi:environment-root  "default")
;(setq python-environment-default-root-name "default")
;(setq python-environment-default-root-name "deeplearn")
;(setq python-environment-directory "~/.virtualenvs")
;(add-hook 'python-mode-hook 'jedi:setup)

(setq js-indent-level 2)
(setq typescript-indent-level 2)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(yas-minor-mode-on)
;(yas-load-directory (concat lib-path "/yasnippet/snippets"))
;(global-set-key "\C-cay" 'yas-insert-snippet)

;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(company-quickhelp-mode 1)
(setq company-dabbrev-downcase nil)     ;防止自动把补全内容变成全小写
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(global-set-key (kbd "M-/") 'company-complete)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
(require 'company-web-html)
(require 'company-dict)
(require 'company-tern)
(push 'company-dict company-backends)
(push 'company-web-html company-backends)
(push 'company-tern company-backends)
;;(load "~/.emacs.d/company-sqlplus.el")
;;(push 'company-sqlplus company-backends)
(push 'company-anaconda company-backends)
(setq company-tooltip-align-annotations t)

;; company与yas的配合
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; company相关的hook
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(add-hook 'python-mode-hook 'my/python-mode-hook)

(add-hook 'js2-jsx-mode-hook 'tern-mode)

(eval-after-load "sql"
  '(load-library "sql-indent"))

;; org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)
   (python . t)
   (emacs-lisp . t)
   (sh . t)))

(setq org-src-fontify-natively t)

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

;;eshell
(require 'eshell)
(require 'eshell-z)
;; 256色显示
(require 'xterm-color)
;; comint install
(progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions)))
;; comint uninstall
;;(progn (remove-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
;;       (add-to-list 'comint-output-filter-functions 'ansi-color-process-output))
(add-hook 'eshell-mode-hook
          (lambda ()
            (setq xterm-color-preserve-properties t)))
(add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
(setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))

;; initial window
(setq initial-frame-alist
      '(
        (width . 102) ; character
        (height . 45) ; lines
        ))

;; default/sebsequent window
(setq default-frame-alist
      '(
        (width . 100) ; character
        (height . 45) ; lines
        ))

;; 全局设置
;; 字体
;(set-default-font "YaHei Consolas Hybrid-12")
;(set-frame-font "Consolas-11")
;(set-fontset-font "fontset-default" 'han '("Microsoft YaHei" . "unicode-bmp"))

;(print (font-family-list))显示所有字体
(set-default-font "Monaco 14")          ;默认字体和字号
(set-fontset-font "fontset-default" 'han '("STHeiti")) ;中文字体
(setq face-font-rescale-alist '(("STHeiti" . 1.2)))    ;中文字体缩放，处理中英文等宽问题

;; 新建Frame的默认字体
(add-to-list 'default-frame-alist '(font . "Monaco 14"))

;; desktop 
(desktop-save-mode t)
;; session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
;; theme
;(load-theme 'wombat t)
(load-theme 'zenburn t)
;; 高亮当前行
;; (global-hl-line-mode t)
;; 禁止产生备份
(setq make-backup-files nil)
;; 关闭Emacs启动时提示信息
(setq inhibit-startup-message t)
;; 启动语法高亮
(global-font-lock-mode 't)
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
;; 显示行号
(global-linum-mode 0)
;; shift-space 
;(global-set-key [?\S- ] 'set-mark-command)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
;; 退出确认
(setq confirm-kill-emacs 'yes-or-no-p)

;; 启动server
(server-start)

;; edit-server
;(edit-server-start)

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

(defun my-clone-and-open-file (filename)
  "Clone the current buffer writing it into FILENAME and open it"
  (interactive "FClone to file: ")
  (save-restriction
    (widen)
    (write-region (point-min) (point-max) filename nil nil nil 'confirm))
  (find-file filename))

(defun my-backup-file (filename)
  "Backup the current buffer writing it into FILENAME."
  (interactive "FBackup to file: ")
  (save-restriction
    (widen)
    (write-region (point-min) (point-max) filename nil nil nil 'confirm)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(font-lock-maximum-decoration (quote ((sqlplus-mode . 1))))
 '(markdown-command
   "pandoc -s --include-in-header=/Users/zhujie/Documents/devel/docs/markdown/src/pandoc.header -c http://johnmacfarlane.net/pandoc/demo/pandoc.css")
 '(package-selected-packages
   (quote
    (zenburn-theme ein multi-term sql-indent lua-mode company-anaconda anaconda-mode edit-server magit emmet-mode company-tern helm-swoop switch-window company company-web company-quickhelp company-dict scala-mode xterm-color eshell-z ace-jump-zap ace-jump-mode 2048-game typescript-mode yasnippet web-mode sqlplus session markdown-mode js2-mode htmlize helm-projectile dash color-theme-solarized)))
 '(session-use-package t nil (session)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
