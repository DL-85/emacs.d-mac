;;; 在写C的时候使用cscope来查看源码
(require 'xcscope)

(peng-global-set-key (kbd "C-c s s") 'cscope-find-this-symbol)
(peng-global-set-key (kbd "C-c s d") 'cscope-find-global-definition)
(peng-global-set-key (kbd "C-c s g") 'cscope-find-global-definition)
(peng-global-set-key (kbd "C-c s G") 'cscope-find-global-definition-no-prompting)
(peng-global-set-key (kbd "C-c s c") 'cscope-find-functions-calling-this-function)
(peng-global-set-key (kbd "C-c s C") 'cscope-find-called-functions)
(peng-global-set-key (kbd "C-c s t") 'cscope-find-this-text-string)
(peng-global-set-key (kbd "C-c s e") 'cscope-find-egrep-pattern)
(peng-global-set-key (kbd "C-c s f") 'cscope-find-this-file)
(peng-global-set-key (kbd "C-c s i") 'cscope-find-files-including-file)
(peng-global-set-key (kbd "C-c s b") 'cscope-display-buffer)
(peng-global-set-key (kbd "C-c s B") 'cscope-display-buffer-toggle)
(peng-global-set-key (kbd "C-c s n") 'cscope-next-symbol)
(peng-global-set-key (kbd "C-c s N") 'cscope-next-file)
(peng-global-set-key (kbd "C-c s p") 'cscope-prev-symbol)
(peng-global-set-key (kbd "C-c s P") 'cscope-prev-file)
(peng-global-set-key (kbd "C-c s u") 'cscope-pop-mark)
(peng-global-set-key (kbd "C-c s a") 'cscope-set-initial-directory)
(peng-global-set-key (kbd "C-c s A") 'cscope-unset-initial-directory)
(peng-global-set-key (kbd "C-c s L") 'cscope-create-list-of-files-to-index)
(peng-global-set-key (kbd "C-c s I") 'cscope-index-files)
(peng-global-set-key (kbd "C-c s E") 'cscope-edit-list-of-files-to-index)
(peng-global-set-key (kbd "C-c s W") 'cscope-tell-user-about-directory)
(peng-global-set-key (kbd "C-c s S") 'cscope-tell-user-about-directory)
(peng-global-set-key (kbd "C-c s T") 'cscope-tell-user-about-directory)
(peng-global-set-key (kbd "C-c s D") 'cscope-dired-directory)

(provide 'init-xcscope)