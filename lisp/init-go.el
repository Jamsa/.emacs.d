(when *is-a-mac*
  ;; go语言环境变量
  (setenv "GOPATH" (concat (getenv "HOME") "/Documents/devel/go"))
  (setenv "GOROOT" "/usr/local/opt/go/libexec")
  (setenv "GOBIN" (concat (getenv "GOPATH") "/bin"))
  (setenv "PATH" (concat (getenv "PATH") ":" (getenv "GOPATH") "/bin"))
  (setenv "PATH" (concat (getenv "PATH") ":" (getenv "GOROOT") "/bin")))

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))


(provide 'init-go)
