(require 'company)

;;; 打开company-mode
;; (add-hook 'prog-mode-hook 'global-company-mode)
;; (add-hook 'cmake-mode-hook 'global-company-mode)
;; (add-hook 'after-init-hook 'global-company-mode)

;;; use `C-n C-p' to select
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(global-set-key (kbd "C-c o") 'company-complete)
(setq company-require-match nil)

;;; space don't run the complete
(setq company-auto-complete nil)

(eval-after-load 'company
  '(progn
     (add-to-list 'company-backends 'company-cmake)
     ;; can't work with TRAMP
     (setq company-backends (delete 'company-ropemacs company-backends))

     ;; (setq company-backends (delete 'company-capf company-backends))
     ;; I don't like the downcase word in company-dabbrev
     ;; for languages use camel case naming convention

     (setq company-dabbrev-downcase nil)
     (setq company-dabbrev-ignore-case t)

     (setq company-show-numbers t)
     ;; (setq company-begin-commands '(self-insert-command))
     (setq company-idle-delay 0)
     (setq company-clang-insert-arguments nil)
     ))

;; (defun complete-or-indent ()
;;   (interactive)
;;   (if (company-manual-begin)
;;       (company-complete-common)
;;     (indent-according-to-mode)))


;; (setq company-backends '(
;; 			 ;; (
;; 			 ;; company-clang
;; 			 ;; company-xcode
;; 			 ;; company-keywords
;; 			 ;; company-semantic
;; 			 ;; company-capf
;; 			 ;; company-dabbrev
;; 			 ;; )
;; 			 company-bbdb
;; 			 company-nxml
;; 			 company-semantic
;; 			 company-clang
;; 			 company-xcode
;; 			 company-cmake

;; 			 (company-dabbrev-code
;; 			  company-gtags
;; 			  company-etags
;; 			  company-keywords)
			 
;; 			 company-oddmuse
;; 			 company-files
;; 			 company-eclim
;; 			 company-dabbrev
;; 			 ))


;;; 和`yaxsnippet'结合使用的。用的比较少了。
;; (require 'yasnippet)
;; (defun check-expansion ()
;;   (save-excursion
;;     (if (looking-at "\\_>") t
;;       (backward-char 1)
;;       (if (looking-at "\\.") t
;; 	(backward-char 1)
;; 	(if (looking-at "->") t nil)))))

;; (defun do-yas-expand ()
;;   (let ((yas/fallback-behavior 'return-nil))
;;     (yas/expand)))

;; (defun tab-indent-or-complete ()
;;   (interactive)
;;   (if (minibufferp)
;;       (minibuffer-complete)
;;     (if (or (not yas/minor-mode)
;; 	    (null (do-yas-expand)))
;; 	(if (check-expansion)
;; 	    (company-complete-common)
;; 	  (indent-for-tab-command)))))

(define-key evil-insert-state-map (kbd "C-t") 'company-other-backend) ;快速切换backends
(define-key evil-emacs-state-map (kbd "C-t") 'company-other-backend) ;快速切换backends

(provide 'init-company-mode)
