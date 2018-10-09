;; markdown-mode
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))
(markdown-toggle-math t)                ;启用对mathjax的支持

(provide 'init-markdown)
