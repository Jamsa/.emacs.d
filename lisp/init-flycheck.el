(require 'flycheck)
(require 'js2-mode)
(require 'web-mode)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; flycheck eslint
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
;(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)
;(flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(json-jsonlist)))

(provide 'init-flycheck)
