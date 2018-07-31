(defvar sqlcl-proc-path "~/Applications/SQLDeveloper.app/Contents/Resources/sqldeveloper/sqldeveloper/bin/sql" "Path to the program used by `sqlcl-run`")
(defvar sqlcl-proc-args '("spm/spm2017_2p@HEBEI_PROD") "Commandline arguments to pass to `sqlcl'")
(defvar sqlcl-mode-map
  (let ((map (nconc (make-sparse-keymap) comint-mode-map)))
    (define-key map "\t" 'completion-at-point)
    map)
  "Basic mode map for `sqlcl-run'")
(defvar sqlcl-prompt-regexp "^SQL\>\s" "Prompt for `sqlcl-run'")

(defun sqlcl-run ()
  "Run an inferior instance of `sqlcl' inside Emacs."
  (interactive)
  (let* ((sqlcl-program sqlcl-proc-path)
         (buffer (comint-check-proc "SQLcl")))
    ;; pop to the "*SQLcl*" buffer if the process is dead, the
    ;; buffer is missing or it's got the wrong mode.
    (pop-to-buffer-same-window
     (if (or buffer (not (derived-mode-p 'sqlcl-mode))
             (comint-check-proc (current-buffer)))
         (get-buffer-create (or buffer "*SQLcl*"))
       (current-buffer)))
    ;; create the comint process if there is no buffer.
    (unless buffer
      (apply 'make-comint-in-buffer "SQLcl" buffer
             sqlcl-program sqlcl-proc-args)
      (sqlcl-mode))))

(defun sqlcl-initialize ()
  "Helper function to initialize Sqlcl"
  (setq comint-process-echoes t)
  (setq comint-use-prompt-regexp t)
  (add-hook 'comint-output-filter-functions '(lambda (txt) (message txt))))

(define-derived-mode sqlcl-mode comint-mode "Sqlcl"
  "Major mode for `run-sqlcl'.

\\<sqlcl-mode-map>"
  nil "Sqlcl"
  ;; this sets up the prompt so it matches things like: [foo@bar]
  (setq comint-prompt-regexp sqlcl-prompt-regexp)
  ;; this makes it read only; a contentious subject as some prefer the
  ;; buffer to be overwritable.
  (setq comint-prompt-read-only t)
  ;; this makes it so commands like M-{ and M-} work.
  (set (make-local-variable 'paragraph-separate) "\\'")
 ;; (set (make-local-variable 'font-lock-defaults) '(sqlcl-font-lock-keywords t))
  (set (make-local-variable 'paragraph-start) sqlcl-prompt-regexp))

;; this has to be done in a hook. grumble grumble.
(add-hook 'sqlcl-mode-hook 'sqlcl-initialize)
 
