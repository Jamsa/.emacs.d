; web-mode
(require 'web-mode)
(require 'add-node-modules-path)
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
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsm?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
;;(setq web-mode-markup-indent-offset 2)

;; 字义子模式
(setq web-mode-content-types-alist
      '(("vue" . "\\.vue\\'")))

;; emmet
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
;(setq web-mode-hook nil)
(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            (setq web-mode-indent-style 2)
            (setq web-mode-script-padding 0)
            (setq web-mode-style-padding 0)
            ;;(if (equal web-mode-content-type '("html")))
            (if (equal web-mode-content-type "vue")
                (progn
                  (add-node-modules-path) ;查找项目目录下的eslint
                  (flycheck-add-mode 'javascript-eslint 'web-mode)
                  (flycheck-select-checker 'javascript-eslint)))))

;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (add-to-list (make-local-variable 'company-backends)
;;                          '(company-web-html))))
(provide 'init-web)
