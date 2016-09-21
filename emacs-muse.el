;(add-to-list 'load-path (concat lib-path "/muse/lisp"))
(defvar my-muse-publish-directory "e:\\devel\\docs\\muse\\publish_html")
(require 'muse-mode)
(require 'muse-html) ;; and so on
(require 'muse-project)
(require 'muse-latex)
;;(require 'muse-colors)
;;(require 'muse-publish)
;;(require 'muse-docbook)
;;(require 'muse-wiki)

;; 以不同的颜色来显示的方式out line而不放大字体
(setq muse-colors-autogen-headings 'outline)


;; (define-key muse-mode-map [tab] 'indent-for-tab-command)
(define-key muse-mode-map [tab] 'yas/expand)
(add-hook 'muse-mode-hook
	  '(lambda ()
	     (yas/minor-mode-on)))

(setq muse-project-alist
      `(
	;; ("wiki"                         ; 项目名
	;;      ("e:\\devel\\docs\\muse\\pages"      ;源文件位置
	;;       :default "index"              ;默认主页
	;;       ;;:force-publish ("WikiIndex") ;发布项目时同步发布Project的索引文件
	;;       )
	;;      (:base "my-xhtml" :path "e:\\devel\\docs\\muse\\publish_html"))

	("wiki" (,@(muse-project-alist-dirs "e:\\devel\\docs\\muse\\pages") :default "index")
	 ;; 发布为blog-xhtml风格
	 ,@(muse-project-alist-styles "e:\\devel\\docs\\muse\\pages" "e:\\devel\\docs\\muse\\publish_html" "blog-xhtml")
	 ;;  ;; 发布为docbook风格
	 ;;  ,@(muse-project-alist-styles "e:\\devel\\docs\\muse\\pages" "e:\\devel\\docs\\muse\\docbook" "docbook"))
	 ))

      
      )

;; 修改当前的样式
(setq my-different-style-sheet
      (concat "<link rel=\"stylesheet\" type=\"text/css\""
              " charset=\"utf-8\" media=\"all\""
              " href=\"./muse.css\" />"))

(muse-derive-style "my-xhtml" "xhtml"
                   ;;:header "d:/cygwin/home/zhujie/.emacs.d/muse-header.html"
                   ;;:footer "d:/cygwin/home/zhujie/.emacs.d/muse-footer.html"
                   :style-sheet my-different-style-sheet
                   )

(muse-derive-style "blog-xhtml" "xhtml"
                   :header "~/.emacs.d/muse/muse-header.html"
                   :footer "~/.emacs.d/muse/muse-footer.html"
		   ;;                   :style-sheet my-different-style-sheet
                   )



;; 搜索到的一些函数
(defun ywb-muse-relative-path (file)
  (concat
   (file-relative-name
    my-muse-publish-directory
    (file-name-directory muse-publishing-current-output-path))
   file))


;;;_+ insert toplink in html files
;; (defun ywb/muse-publish-markup-heading ()
;;    (let* ((len (length (match-string 1)))
;;           (start (muse-markup-text
;;                   (cond ((= len 1) 'section)
;;                         ((= len 2) 'subsection)
;;                         ((= len 3) 'subsubsection)
;;                         (t 'section-other))
;;                   len))
;;           (end   (muse-markup-text
;;                   (cond ((= len 1) 'section-end)
;;                         ((= len 2) 'subsection-end)
;;                         ((= len 3) 'subsubsection-end)
;;                         (t 'section-other-end))
;;                   len)))
;;      (delete-region (match-beginning 0) (match-end 0))
;;      (muse-insert-markup start)
;;      (insert
;;       (propertize
;;       "<span class=\"toplink\"><a href=\"#top\">top</a></span>"
;;       'rear-nonsticky '(read-only) 'read-only t))
;;      (end-of-line)
;;      (when end
;;        (muse-insert-markup end))
;;      (muse-publish-section-close len)))
;; (defalias 'muse-publish-markup-heading 'ywb/muse-publish-markup-heading)

