;; js2-mode
(require 'js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
;; (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(setq js-indent-level 2)
(setq js2-basic-offset 2)
;; jsx会显示错误
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

;; typescript
(setq typescript-indent-level 2)


(dolist (hook '(js-mode-hook
                js2-mode-hook
                js2-jsx-mode-hook
                ;js3-mode-hook
                ;inferior-js-mode-hook
                ))
  (add-hook hook
            (lambda ()
              (tern-mode nil)
              (add-to-list (make-local-variable 'company-backends)
                           'company-tern)
              )))


(provide 'init-js2)
