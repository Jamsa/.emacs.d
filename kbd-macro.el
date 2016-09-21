(fset 'append-comma
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("," 0 "%d")) arg)))
(fset 'prepend-comma
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("--" 0 "%d")) arg)))
