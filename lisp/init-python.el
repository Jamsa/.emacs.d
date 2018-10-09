;; python
;(setq jedi:environment-root  "default")
;(setq python-environment-default-root-name "default")
;(setq python-environment-default-root-name "deeplearn")
;(setq python-environment-directory "~/.virtualenvs")
;(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(set-variable 'python-indent-offset 4)

(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends)
                         'company-anaconda)))
(when *is-a-win*
  (setenv "PATH" (concat "c:/tools/miniconda3/envs/dl/;" (getenv "PATH")))
  (setq python-shell-interpreter "c:\\tools\\miniconda3\\envs\\dl\\python.exe")
  (pythonic-activate "c:\\tools\\miniconda3\\envs\\dl\\"))



(provide 'init-python)
