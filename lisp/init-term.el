;;eshell
(require 'eshell)
(require 'eshell-z)

(setenv "TERM" "xterm-256color")
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


(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(provide 'init-term)


