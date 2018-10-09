;; rust 语言
(setenv "PATH" (concat (getenv "PATH") ":" (getenv "HOME") "/.cargo/bin"))
(setq exec-path (append '("~/.cargo/bin") exec-path ))
(setenv "RUSTUP_DIST_SERVER" "http://mirrors.ustc.edu.cn/rust-static")
(setenv "RUSTUP_UPDATE_ROOT" "http://mirrors.ustc.edu.cn/rust-static/rustup")

(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends)
                         'company-racer)))

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(provide 'init-rust)
