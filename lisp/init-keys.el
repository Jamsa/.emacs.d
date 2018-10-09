(when *is-a-win*
  (global-unset-key (kbd "C-SPC"))
  (global-set-key (kbd "M-SPC") 'set-mark-command)
  )

;; buffer切换
(global-set-key (kbd "M-s-<left>") 'previous-buffer)
(global-set-key (kbd "M-s-<right>") 'next-buffer)

;;ace
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "M-z") 'ace-jump-zap-to-char)
(global-set-key (kbd "C-x j") 'ace-jump-word-mode)

(provide 'init-keys)
