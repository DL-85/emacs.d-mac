;; ;; pengpengxp's w3m-mode
(require 'smart-tab)
(add-to-list 'load-path (concat SITE-LISP "emacs-w3m"))
(require 'w3m-load)
(provide 'w3m-e23)
(require 'w3m-lnum)
(setq w3m-home-page "www.baidu.com") ;set your home page
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
(setq w3m-use-toolbar t)
;; (setq browse-url-browser-function 'w3m-browse-url)                 ;set w3m as emacs's default browser默认还是不启用算了

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(setq w3m-fill-column 70)
(setq w3m-session-automatic-save 1)
(setq w3m-session-deleted-save 1)
(setq w3m-session-load-last-sessions 1)
(setq w3m-use-title-buffer-name 1)	;use the title as buffer-name

;; 默认显示图片
(setq w3m-default-display-inline-images t)
(setq w3m-default-toggle-inline-images t)

(defun pengpengxp-w3m-mode ()
  (evil-emacs-state 1)
  (setq evil-insert-state-cursor '("black" box))
  (setq evil-emacs-state-cursor '("black" box))
  (setq w3m-lnum-mode 1)
  (setq truncate-lines nil) ;; 一行显示不完就换行。不要显示到另外一页
  (local-set-key (kbd "C-j") 'view-stardict-in-buffer)
  ;; for X-emacs
  (local-set-key (kbd "<C-return>") 'view-stardict-in-buffer)
  (local-set-key (kbd "<down>") 'evil-next-line)
  (local-set-key (kbd "<up>") 'evil-previous-line)
  (local-set-key (kbd "<left>") 'evil-backward-char)
  (local-set-key (kbd "<right>") 'evil-forward-char)
  (local-set-key (kbd "DEL") 'delete-window) ;;?????useless
  (local-set-key (kbd "o") 'w3m-browse-url)
  (local-set-key (kbd "C-w") 'kill-this-buffer)
  (local-set-key (kbd "C-t") 'w3m-goto-new-session-url)
  (local-set-key (kbd "l") 'w3m-next-buffer)
  (local-set-key (kbd "h") 'w3m-previous-buffer)
  (local-set-key (kbd "/") 'isearch-forward)
  (local-set-key (kbd "b") 'switch-to-buffer)
  (smart-tab-mode-off)
  )
(add-hook 'w3m-mode-hook 'pengpengxp-w3m-mode)

(provide 'init-w3m)
