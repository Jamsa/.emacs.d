;; -*- lexical-binding: t -*-

;;; init.el --- 配置文件

;;; Commentary:

;;; Code:


;; 参考purcell方式进行配置
;;(setq debug-on-error t)
(setq debug-on-error nil)

(let ((minver "24.4"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "25.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; 调整GC参数
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;; Bootstrap配置
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-a-win* (eq system-type 'windows-nt))
(defconst *is-a-linux* (eq system-type 'gnu/linux))

(require 'init-elpa)
(require 'init-exec-path)
(require 'init-fonts)
(require 'init-keys)
(require 'init-helm)
(require 'init-projectile)
(require 'init-yasnippet)
(require 'init-company)

(require 'init-markdown)
(require 'init-web)
;(require 'init-js2)
(require 'init-flycheck)
;(require 'init-java)
(require 'init-python)
(require 'init-go)
(require 'init-rust)
;(require 'init-org)
(require 'init-sqlplus)
(require 'init-term)
(require 'init-ein)
(require 'init-utils)



(when *is-a-win*
   (prefer-coding-system 'utf-8)
    (set-default-coding-systems 'utf-8)
    (set-language-environment 'utf-8)
    (set-selection-coding-system 'utf-8))

(global-pangu-spacing-mode 1)

;; initial window
(setq initial-frame-alist
      '(
        (cons 'width (/ (/ (display-pixel-width) 2) (frame-char-width)))
        (cons 'height (- (/ (display-pixel-height) (frame-char-height))) 4)
        ;(width . 102) ; character
        ;(height . 45) ; lines
        ))

;; default/sebsequent window
(setq default-frame-alist
      '(
        (cons 'width (/ (/ (display-pixel-width) 2) (frame-char-width)))
        (cons 'height (- (/ (display-pixel-height) (frame-char-height)) 4))
       ;(width . 100) ; character
       ;(height . 45) ; lines
        ))

;; 全局设置

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
(setq show-paren-style 'parentheses)    ;parenthesis
;; 高亮选区
;(transient-mark-mode t)
;; 用y/n代替yes/no
(fset'yes-or-no-p 'y-or-n-p)
;; 关闭工具条
(tool-bar-mode 0)
;; 不显示滚动条
(scroll-bar-mode -1)
;; 显示行号
;(global-linum-mode 1)
(global-display-line-numbers-mode 1)
;; shift-space 
;(global-set-key [?\S- ] 'set-mark-command)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;; 退出确认
(setq confirm-kill-emacs 'yes-or-no-p)

;; 启动server
(server-start)

;; edit-server
;(edit-server-start)

(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here

