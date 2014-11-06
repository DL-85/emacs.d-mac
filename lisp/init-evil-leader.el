;;;evil-leader
(require 'evil)
(require 'bm)

;; I find this is very usefull
(global-evil-leader-mode 1)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key 
  "t" 'bm-toggle
  "w" 'save-buffer
  "SPC" 'evil-buffer
  "x" 'execute-extended-command
  "e" 'eshell
  "d" 'kill-this-buffer
  "q" 'kill-buffer-and-window
  "b" 'ibuffer
  "B" 'bookmark-bmenu-list
  "r" 'recentf-open-files
  "TAB" 'switch-to-buffer
  "1" 'delete-other-windows
  "0" 'delete-window
  "2" 'split-window-below
  "3" 'split-window-right
  "DEL" 'delete-other-windows
  "f" 'find-file
  "go" 'peng-ibuffer-filter-org-mode
  "gc" 'peng-ibuffer-filter-c-mode
  "ge" 'peng-ibuffer-filter-emacs-lisp-mode
  "gs" 'peng-ibuffer-filter-sql-mode
  "gd" 'peng-ibuffer-filter-dired-mode
  "gp" 'peng-ibuffer-filter-c++-mode
  "gg" '(lambda ()
	  (interactive)
	  (switch-to-buffer "*scratch*"))
  "hf" 'describe-function
  "hk" 'describe-key
  "hc" 'describe-key-briefly
  "hv" 'describe-variable
  "hm" 'describe-mode
  "hr" 'info-emacs-manual
  "cu" 'winner-undo
  "cr" 'winner-redo
  "cm" 'shell-command
  "cc" 'org-capture
  "v" '(lambda ()
	 (interactive)
	 (cond ((string= major-mode "c-mode")
		(compile (concat "gcc -g "
				 (buffer-file-name)
				 " -pthread;./a.out")))
	       ((string= major-mode "c++-mode")
		(compile (concat "g++ -g "
				 (buffer-file-name)
				 " -pthread ;./a.out")))
	       ))
  "m" '(lambda ()
  	 (interactive)
  	 (compile "make clean;make;")
	 )
  "j" 'bookmark-jump
  "a" 'org-agenda
  )

(provide 'init-evil-leader)
