;; org-mode
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((dot . t)
;;    (python . t)
;;    (emacs-lisp . t)
;;    ;(sh . t)
;;    ))

;; (setq org-src-fontify-natively t)

;; (require 'ox-html)
;; (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;; (setq org-export-html-coding-system 'utf-8-unix)
;; (setq org-html-viewport nil)
;; (setq org-publish-project-alist
;;       '(
;;         ;; ... add all the components here (see below)...
;;         ("blog-notes"
;;          :base-directory "~/Documents/devel/docs/org/notes/" ;org文件的目录
;;          :base-extension "org" ;扩展名
;;          :publishing-directory "~/Documents/devel/docs/org/notes_html/" ;导出目录
;;          :recursive t
;;          :publishing-function org-html-publish-to-html
;;          :headline-levels 4             ; Just the default for this project.
;;          :auto-preamble t
;;          :section-numbers nil
;;          :author "zhujie"
;;          :email "jamsa at gmail dot com"
;;          :auto-sitemap t                ; Generate sitemap.org automagically...
;;          :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
;;          :sitemap-title "站点地图"         ; ... with title 'Sitemap'.
;;          :sitemap-sort-files anti-chronologically
;;          :sitemap-file-entry-format "%d [%t]"
;;          ;:html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://orgmode.org/worg/style/worg.css\"/>"
;;          :html-postamble nil            ;不产生底部明细信息
;;          :html-head-include-default-style nil ;不在html内生成默认的样式内容
;;          :html-validation-link nil            ;去掉valiation显示
;;          :html-link-home "index.html"
;;          :html-link-up "sitemap.html"
;;          )
;;         ("blog-static"
;;          :base-directory "~/Documents/devel/docs/org/notes/"
;;          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
;;          :publishing-directory "~/Documents/devel/docs/org/notes_html/"
;;          :recursive t
;;          :publishing-function org-publish-attachment
;;          )
;;         ("blog" :components ("blog-notes","blog-static"))
;;         ))


(provide 'init-org)
