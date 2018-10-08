(when *is-a-win*
  ;; 字体    
  ;; (print (font-family-list))显示所有字体
  (set-default-font "YaHei Consolas Hybrid-12")
  (set-frame-font "YaHei Consolas Hybrid-12")
  (set-fontset-font "fontset-default" 'han '("Microsoft YaHei" . "unicode-bmp"))
  (add-to-list 'default-frame-alist '(font . "YaHei Consolas Hybrid-12")))

(when *is-a-mac*
  ;; 字体
  (set-default-font "Monaco 14")
  (set-frame-font "Monaco 14")          ;默认字体和字号
  (set-fontset-font "fontset-default" 'han '("STHeiti")) ;中文字体
  (setq face-font-rescale-alist '(("STHeiti" . 1.2)))    ;中文字体缩放，处理中英文等宽问题
  ;; 新建Frame的默认字体
  (add-to-list 'default-frame-alist '(font . "Monaco 14")))

(provide 'init-fonts)
