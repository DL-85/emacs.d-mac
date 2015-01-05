;;; This is pengpengxp's private function

(defun  peng-reset-tags-table ()
  "reset the tags table to my defalt TAGS"
  (interactive)
  (setq tags-table-list
	'("~/.emacs.d/TAGS" "/usr/share/emacs/24.3/TAGS"))
  (setq tags-file-name nil)
  )

(defun  peng-clear-tags-table ()
  "reset the tags table to nil"
  (interactive)
  (setq tags-table-list nil)
  (setq tags-file-name nil)
  )
;;; ----------------------------------------------------------------------
;;; My own copy and paste line functon
;;; ----------------------------------------------------------------------
(defun peng-copy-one-line ()
  "copy one line in my favourite way"
  (interactive)
  (let ((start (line-beginning-position))
	(end (line-end-position)))
    (kill-ring-save start end)
    (goto-char end)))
(defun peng-yank-one-line ()
  "paste one line in my favourite way"
  (interactive)
  (yank)
  (newline))
(global-set-key (kbd "C-c w") 'peng-copy-one-line)
(global-set-key (kbd "C-c y") 'peng-yank-one-line)
;;; ----------------------------------------------------------------------


(defun peng-unshow-all-tools ()
  "hide menu and tool and scroll bar"
  (interactive)
  (when window-system 
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    ))
(defun peng-show-all-tools ()
  "show menu and tool and scroll bar"
  (interactive)
  (when window-system
    (menu-bar-mode t)
    (tool-bar-mode t)
    (scroll-bar-mode t)
    ))

;;; referenced from others
(defun peng-edit-current-file-as-root ()
  "edit current file as root"
  (interactive)
  (if (buffer-file-name)
      (progn
	(setq FILE (concat "/sudo:root@localhost:" (buffer-file-name)))
	(find-file FILE))
    (message "Current buffer does not have an associated file")))

;;; scroll like vim
(defun peng-line-up ()
  "Scroll the page with the cursor in the same line"
  (interactive)
  ;; move the cursor also
  (let ((tmp (current-column)))
    (scroll-down 1)
    (line-move-to-column tmp)
    (forward-line -1)
    )
  )
(defun peng-line-down ()
  "Scroll the page with the cursor in the same line"
  (interactive)
  ;; move the cursor also
  (let ((tmp (current-column)))
    (scroll-up 1)
    (line-move-to-column tmp)
    (forward-line 1)
    )
  )

;;; ----------------------------------------------------------------------
;;; to print current buffer to pdf files
;;; ----------------------------------------------------------------------
(defun peng-print-current-buffer ()
  (interactive)
  (let ((OUTPUT (concat "/tmp/"
			(buffer-name)
			".ps")))
    (save-excursion
      (save-restriction
	(widen)
	(ps-print-buffer OUTPUT)
	(cd "/tmp/")
	(shell-command (concat "ps2pdf "
			       OUTPUT))))))
;;; need to install emacs-intl-fonts in ubuntu,and then set this variable,it can print chinese now
(setq ps-multibyte-buffer 'bdf-font-except-latin)
;;; ----------------------------------------------------------------------

;;; ----------------------------------------------------------------------
;;; need to be improved
;;; ----------------------------------------------------------------------
(defun peng-list-current-file-tags ()
  "list current files tags"
  (interactive)
  (flet ((yes-or-no-p (args) t)
	    (y-or-n-p (args) t))
    (shell-command (concat "etags " 
			   (format "%s" (buffer-file-name))))
    (visit-tags-table (concat (helm-current-directory)
			      "TAGS"))
    (list-tags (buffer-file-name))
    (delete-window)
    (switch-to-buffer "*Tags List*")
    (delete-other-windows)
    ))
;;; ----------------------------------------------------------------------

;;; ----------------------------------------------------------------------
;;; eyerest function
;;; ----------------------------------------------------------------------
(defun peng-eyerest-reset ()
  (interactive)
  (shell-command "eyerest-cli -r"))
(defun peng-eyerest-show-rest ()
  (interactive)
  (let ((time (string-to-int (shell-command-to-string "eyerest-cli -t %s"))))
    (message "%d:%d" (/ time 60)
	     (% time 60))))
(defun peng-eyerest-pause()
  (interactive)
  (shell-command "eyerest-cli -p"))
(defun peng-eyerest-continue ()
  (interactive)
  (shell-command "eyerest-cli -c"))
(defun peng-eyerest-restart ()
  (interactive)
  (let ((iseyerest (shell-command-to-string "eyerest-cli -s|grep -i active")))
    (if (string= iseyerest "")
	(shell-command "eyerest-daemon")
      (shell-command "killall eyerest-daemon;eyerest-daemon"))))
(defun peng-eyerest-kill ()
  (interactive)
  (shell-command "killall eyerest-daemon"))
(defun peng-eye-gymnistic ()
  (interactive)
  (async-shell-command "mplayer /home/pengpengxp/music/eye_gymnastics.mp3" nil))
;;; ----------------------------------------------------------------------


(defun peng-goto-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))
(defun peng-show-major-mode ()
  (interactive)
  (message "%s" major-mode))

;;; ----------------------------------------------------------------------
;;; global-set-key with evil
;;; ----------------------------------------------------------------------
(defun peng-global-set-key (keys function)
  "use for key-binding with evil
bind in global map and all evil map to make sure it works as I want
绑定所有map。这才是是我需要的global-set-key
usage: (peng... \"keys-you-want-to-bind\" 'function-you-want-to-bind  "
  (define-key evil-normal-state-map keys function)
  (define-key evil-emacs-state-map keys function)
  (define-key evil-insert-state-map keys function)
  (define-key evil-motion-state-map keys function)
  (define-key evil-visual-state-map keys function)
  (define-key evil-replace-state-map keys function)
  (define-key evil-operator-state-map keys function)
  (define-key global-map keys function)
  )
;;; ----------------------------------------------------------------------


;;; ----------------------------------------------------------------------
;;; local-set-key with evil
;;; ----------------------------------------------------------------------
(defun peng-local-set-key (keys function)
  "use for key-binding with evil bind in local map and all evil
map to make sure it works as I want

绑定所有local-map。这才是是我需要的每个不同mode中的local-set-key
usage: (peng... \"keys-you-want-to-bind\"
'function-you-want-to-bind "
  (define-key evil-normal-state-local-map keys function)
  (define-key evil-emacs-state-local-map keys function)
  (define-key evil-insert-state-local-map keys function)
  (define-key evil-motion-state-local-map keys function)
  (define-key evil-visual-state-local-map keys function)
  (define-key evil-replace-state-local-map keys function)
  (define-key evil-operator-state-local-map keys function)
  )
;;; ----------------------------------------------------------------------

;;; ----------------------------------------------------------------------
;;; I modified the from the helm-src file
;;; ----------------------------------------------------------------------
(defun peng-helm-etags-select (arg)
  "Preconfigured helm for etags.
If called with a prefix argument or if any of the tag files have
been modified, reinitialize cache.

This function aggregates three sources of tag files:

  1) An automatically located file in the parent directories, by `helm-etags-get-tag-file'.
  2) `tags-file-name', which is commonly set by `find-tag' command.
  3) `tags-table-list' which is commonly set by `visit-tags-table' command."
  (interactive "P")
  (let ((tag-files (helm-etags-all-tag-files))
        ;; (helm-execute-action-at-once-if-one helm-etags-execute-action-at-once-if-one)
        (helm-execute-action-at-once-if-one nil)
        (str (thing-at-point 'symbol))
	)
    (if (cl-notany 'file-exists-p tag-files)
        (message "Error: No tag file found. Create with etags shell command, or visit with `find-tag' or `visit-tags-table'.")
      (cl-loop for k being the hash-keys of helm-etags-cache
            unless (member k tag-files)
            do (remhash k helm-etags-cache))
      (mapc (lambda (f)
              (when (or (equal arg '(4))
                        (and helm-etags-mtime-alist
                             (helm-etags-file-modified-p f)))
                (remhash f helm-etags-cache)))
            tag-files)
      (helm :sources 'helm-source-etags-select
            :keymap helm-etags-map
            :default (list (concat "\\_<" str "\\_>") str)
            :buffer "*helm etags*"))))
;;; ----------------------------------------------------------------------

(defun peng-insert-counter-column (n)
  "insert 1 to n in n column
    Example: n = 3,insert:
    insert: 1
    insert: 2
    insert: 3
    NOTE:referenced from xahlee"
  (interactive "nEnter the column number you want to insert: ")
  (let ((colpos (- (point) (point-at-bol)))
	(i 1))
    (while (<= i n)
      (insert (number-to-string i))
      (next-line)
      (beginning-of-line)
      (forward-char colpos)
      (setq i (1+ i)))))

(defun peng-compile-current-file-as-plain-tex ()
  "compile current file as plain tex.
This function will send the current file to tex, and then input
the `\end' to end the tex program. At last, use evince to display the result"
  (interactive)
  (let ((file-name (file-name-base)))
    (compile (concat "tex "
		     file-name
		     ".tex"
		     "'\\end';"
		     "evince "
		     file-name
		     ".dvi"))))

(defun peng-change-current-file-to-executable ()
  "Change current file to executable"
  (interactive)
  (let ((file-name (buffer-file-name)))
    (shell-command (concat "chmod a+x "
			   file-name))))

(defun peng-compile-current-latex-file-to-pdf ()
  "把当前的buffer当做latax源文件来编译了

默认的是调用三次xelatex，然后删除中间文件如果有其它需要，请直接使
用命令行来完成"
  (interactive)
  (let ((tempfile (file-name-base))
	(temppro "xelatex"))
    (shell-command (concat  "rm -rf " tempfile ".bbl " tempfile ".blg " 
			    tempfile ".out " tempfile ".log " tempfile ".aux " 
			    tempfile ".toc" tempfile ".pdf"))
    (compile (concat "xelatex "
		     (concat tempfile ".tex")
		     ";xelatex "
		     (concat tempfile ".tex")
		     ";xelatex "
		     (concat tempfile ".tex")
		     (concat  ";rm -rf " tempfile ".bbl " tempfile ".blg " 
			      tempfile ".out " tempfile ".log " tempfile ".aux " 
			      tempfile ".toc" ";evince " tempfile ".pdf")))))

(defun peng-org-latex-export-to-pdf-and-open ()
  "Export the org source file to pdf, delete the intermediate
file and open the pdf file."
  (interactive)
  (save-excursion
      (let ((TEMPFILE (message "%s" (file-name-base))))
	(progn
	  (shell-command (concat "rm -rf " TEMPFILE ".pdf"))
	  (org-latex-export-to-latex)
	  (compile (concat "xelatex "
			   (concat TEMPFILE ".tex")
			   ";xelatex "
			   (concat TEMPFILE ".tex")
			   ";xelatex "
			   (concat TEMPFILE ".tex")
			   (concat  ";rm -rf " TEMPFILE ".bbl " TEMPFILE ".blg " 
				    TEMPFILE ".out " TEMPFILE ".log " TEMPFILE ".aux " 
				    TEMPFILE ".toc" ";rm -f " TEMPFILE ".tex"
				    ";evince " TEMPFILE ".pdf")))
	  ))))

(defun peng-run-current-script ()
  "make current file excutbale and just run it

Not just shell-script, You can run any script as you like"
  (interactive)
  (let ((temp-file-full-name (buffer-file-name))
	(temp-file-base-name (file-name-base)))
    (if temp-file-full-name
	(if (not (= (shell-command (concat "test -x " temp-file-full-name)) 0))
	    (progn
	      (shell-command (concat "chmod a+x " temp-file-full-name))
	      (compile temp-file-full-name))
	  (progn
	    (compile temp-file-full-name)))
      )))

(defun peng-async-shell-command (COM)
  "Run the shell command asynchronize Don't ask me whether to
create a new buffer just because the default buffer is used.

For this reason, I create a random output buffer rather than the
default one every time I launch a shell command.

The COM is what you want to excute. It MUST be a string."
  (save-window-excursion
    (save-excursion
      (let ((RANDOM-NUM (message "%s" (random 10000))))
      (async-shell-command COM
			   (get-buffer-create 
			    (concat "peng-async-shell-command-output-" RANDOM-NUM)))  
	))))

(provide 'init-peng-prifun)
