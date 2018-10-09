
;; company
(require 'company)
(require 'company-web-html)
(require 'company-dict)
(require 'company-tern)
(require 'company-files)
(require 'company-keywords)
(require 'company-capf)
(require 'company-go)

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

;; set default `company-backends'
(setq company-backends
      '((company-files          ; files & directory
         company-keywords       ; keywords
         company-capf
         company-yasnippet
         company-dict)
        (company-abbrev company-dabbrev)))

(provide 'init-company)
