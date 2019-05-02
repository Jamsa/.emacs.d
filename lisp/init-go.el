(when *is-a-mac*
  ;; go语言环境变量
  (setenv "GOPATH" (concat (getenv "HOME") "/Documents/devel/go"))
  (setenv "GOROOT" "/usr/local/opt/go/libexec")
  (setenv "GOBIN" (concat (getenv "GOPATH") "/bin"))
  (setenv "PATH" (concat (getenv "PATH") ":" (getenv "GOPATH") "/bin"))
  (setenv "PATH" (concat (getenv "PATH") ":" (getenv "GOROOT") "/bin"))
  (setq exec-path (append (list (concat (getenv "GOPATH") "/bin")) exec-path ))
  (setq exec-path (append (list (concat (getenv "GOROOT") "/bin")) exec-path )))

;; 修复go vet错误 https://github.com/flycheck/flycheck/issues/1523
(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
    (setf (cdr govet) (cddr govet))))

(with-eval-after-load 'company
  (require 'company-go)
  (add-hook 'go-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends) '(company-go))
              (company-mode))))

(provide 'init-go)
