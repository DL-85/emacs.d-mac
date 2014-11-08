;;; for compilation mode
(defun peng-compilation-mode ()
  "cumstomize my compilation-mode"
  (local-set-key (kbd "DEL") (lambda ()
  		      (interactive)
  		      (bury-buffer)
  		      (delete-window)))
  (switch-to-buffer-other-window "*compilation*") ; 有compilationbuffer的时候每次都自动跳转到这个buffer
  (local-set-key (kbd "<tab>") 'compilation-next-error)
)
(add-hook 'compilation-mode-hook 'peng-compilation-mode)

(provide 'init-compilation)
