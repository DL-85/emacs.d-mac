(setq EVIL-DIR (concat SITE-LISP "evil/"))
(add-to-list 'load-path EVIL-DIR)
(add-to-list 'load-path (concat EVIL-DIR "evil-surround"))
(add-to-list 'load-path (concat EVIL-DIR "evil-nerd-commenter"))
(add-to-list 'load-path (concat EVIL-DIR "evil-visualstar"))
(add-to-list 'load-path (concat EVIL-DIR "evil-leader"))
(add-to-list 'load-path (concat EVIL-DIR "evil-numbers"))
(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(require 'evil-nerd-commenter)
(require 'evil-visualstar)
(require 'evil-leader)
(evilnc-default-hotkeys)
(global-evil-surround-mode 1)

(require 'evil-matchit)			;在对应的tag中跳转，但是还是有些bug。
(global-evil-matchit-mode 1)

(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 设置这些模式的默认evil模式，我原本希望这些模式都是emacs模式，但是这
;;; 让我的evil-leader不是特别方便跳转，所以最后我干脆还是直接指定有些
;;; mode的默认模式为normal，然后手动把我需要的按键绑定上
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(evil-set-initial-state 'ibuffer-mode 'emacs)
(evil-set-initial-state 'bookmark-bmenu-mode 'emacs)
(evil-set-initial-state 'compilation-mode 'emacs)
(evil-set-initial-state 'compilation-mode 'emacs)
(evil-set-initial-state 'apropos-mode 'emacs)
(evil-set-initial-state 'magit-mode  'emacs)
(evil-set-initial-state 'magit-process-mode 'emacs)
(evil-set-initial-state 'mew-draft-mode 'emacs)
(evil-set-initial-state 'mew-summary-mode 'emacs)
(evil-set-initial-state 'mew-message-mode 'emacs)
(evil-set-initial-state 'bm-show-mode 'emacs)
(evil-set-initial-state 'w3m-mode  'emacs)
(evil-set-initial-state 'calendar-mode 'emacs)
(evil-set-initial-state 'gnus-group-mode 'emacs)
(evil-set-initial-state 'inferior-scheme-mode 'emacs)
(evil-set-initial-state 'Man-mode 'normal)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'cfw:details-mode 'emacs)

;;; pengpengxp's evil-toc-mode
(evil-set-initial-state 'reftex-toc-mode 'normal)
(add-hook 'reftex-toc-mode-hook '(lambda ()
			     (interactive)
			     (define-key evil-normal-state-local-map (kbd "TAB") 'forward-button)
			     (define-key evil-normal-state-local-map (kbd "<tab>") 'forward-button)
			     (define-key evil-normal-state-local-map (kbd "<backtab>") 'backward-button)
			     (define-key evil-normal-state-local-map (kbd "<S-iso-lefttab>") 'backward-button)
			     (define-key evil-normal-state-local-map (kbd "q") 'reftex-toc-quit)
			     (define-key evil-normal-state-local-map (kbd "r") 'reftex-toc-rescan)
			     ;; (define-key evil-normal-state-local-map (kbd "SPC") 'reftex-toc-view-line)
			     (define-key evil-normal-state-local-map (kbd "RET") 'reftex-toc-goto-line-and-hide)
			     (define-key evil-normal-state-local-map (kbd "l") 'reftex-toc-toggle-labels)
			     (define-key evil-normal-state-local-map (kbd "f") 'reftex-toc-toggle-follow)
			     (define-key evil-normal-state-local-map (kbd "x") 'reftex-toc-external)
			     (define-key evil-normal-state-local-map (kbd "?") 'reftex-toc-show-help)
			     ))

;;; pengpengxp's evil-help-mode
(evil-set-initial-state 'help-mode 'normal)
(add-hook 'help-mode-hook '(lambda ()
			     (interactive)
			     (define-key evil-normal-state-local-map (kbd "TAB") 'forward-button)
			     (define-key evil-normal-state-local-map (kbd "<tab>") 'forward-button)
			     (define-key evil-normal-state-local-map (kbd "<backtab>") 'backward-button)
			     (define-key evil-normal-state-local-map (kbd "<S-iso-lefttab>") 'backward-button)
			     (define-key evil-normal-state-local-map (kbd "q") 'quit-window)
			     ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; esc就是退出insert模式。不再是emacs中的esc
(setq evil-esc-delay 0)

;;; evil-commenter config
(setq evilnc-hotkey-comment-operator ",,")

;;;设置evil各个模式cursor的形状
(setq evil-insert-state-cursor '("black" box))
(setq evil-emacs-state-cursor '("black" box))

;; ***************************************************************copy
;; remove all keybindings from insert-state keymap,it is VERY VERY important
(setcdr evil-insert-state-map nil) 

;;;把emacs模式下的按键绑定到Insert模式下
(define-key evil-insert-state-map
  (read-kbd-macro evil-toggle-key) 'evil-emacs-state)


;; but [escape] should switch back to normal state
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;;; use "kj" to return normal mode from insert mode 
;;; 这个函数不是很懂
(define-key evil-insert-state-map "k" #'cofi/maybe-exit)
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "k")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
			   nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
	(delete-char -1)
	(set-buffer-modified-p modified)
	(push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
					      (list evt))))))))
;; ***************************************************************copy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; evil-define-key
(define-key evil-normal-state-map (kbd "M-n") 'scroll-up-command)

(define-key evil-normal-state-map "m" 'point-to-register)
(define-key evil-normal-state-map "'" 'jump-to-register)
(define-key evil-normal-state-map "-" 'split-window-below)
(define-key evil-normal-state-map "|" 'split-window-right)
(define-key evil-normal-state-map "q" 'View-quit)
(define-key evil-normal-state-map (kbd "C-n") 'evil-next-line)
(define-key evil-normal-state-map (kbd "C-r") 'isearch-backward)
(define-key evil-normal-state-map (kbd "C-p") 'evil-previous-line)
(define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-normal-state-map (kbd "M-.") 'find-tag)
(define-key evil-normal-state-map (kbd "C-b") 'backward-char)
(define-key evil-normal-state-map (kbd "C-f") 'forward-char)
(define-key evil-normal-state-map (kbd "K") 'man)

(define-key evil-motion-state-map "-" 'split-window-below)
(define-key evil-motion-state-map "|" 'split-window-right)
(define-key evil-motion-state-map "m" 'point-to-register)
(define-key evil-motion-state-map "'" 'jump-to-register)
(define-key evil-motion-state-map (kbd "C-n") 'evil-next-line)
(define-key evil-motion-state-map (kbd "C-r") 'isearch-backward)
(define-key evil-motion-state-map (kbd "C-p") 'evil-previous-line)
(define-key evil-motion-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-motion-state-map (kbd "M-.") 'find-tag)

 ;;; visual-map
(define-key evil-visual-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-visual-state-map (kbd "C-b") 'backward-char)
(define-key evil-visual-state-map (kbd "C-f") 'forward-char)

;; evil quit
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'helm-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'helm-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'helm-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'helm-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'helm-keyboard-quit)

(define-key evil-normal-state-map (kbd "DEL") 'delete-other-windows)
(define-key evil-motion-state-map (kbd "DEL") 'delete-other-windows)
(define-key evil-normal-state-map (kbd "<backspace>") 'delete-other-windows)
(define-key evil-motion-state-map (kbd "<backspace>") 'delete-other-windows)
(define-key evil-normal-state-map "ei " 'find-file)
(define-key evil-motion-state-map "ei " 'find-file)

;;; define two special key for personal use
(require 'init-evil-spc-map)

;; (require 'init-evil-comma-map)

(provide 'init-evil)
