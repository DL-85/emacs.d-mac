;;; --------------------------------------------------------------------------------
;;; 设置环境变量
;;; --------------------------------------------------------------------------------
(setenv "PATH" (shell-command-to-string "bash -i -c 'echo -n $PATH' 2>/dev/null"))

(setq HOME (getenv "HOME"))
(setq DIR (concat HOME "/.emacs.d"))
(setq GTD (concat HOME "/gtd"))
(setq LISP (concat DIR "/lisp"))
(setq SITE-LISP (concat DIR "/site-lisp"))
(add-to-list 'load-path DIR)
(add-to-list 'load-path SITE-LISP)
(add-to-list 'load-path LISP)
(let ((default-directory SITE-LISP))	;Don't add load-path after plugins every time
  (normal-top-level-add-subdirs-to-load-path))

;;; my plugins
(require 'init-peng-copyfun)		;;;; some function I copyed from others
(require 'init-peng-prifun)		;;;; load function wrote by pengpengxp


(require 'org)
(require 'org-list)

(require 'ox)
(require 'ox-html)
(require 'ox-publish)


;;;这两个函数可以使得org导出html时候不出现换行变空格的问题。
(defun clear-single-linebreak-in-cjk-string (string)
  "clear single line-break between cjk characters that is usually soft line-breaks"
  (let* ((regexp "\\([\u4E00-\u9FA5]\\)\n\\([\u4E00-\u9FA5]\\)")
         (start (string-match regexp string)))
    (while start
      (setq string (replace-match "\\1\\2" nil nil string)
            start (string-match regexp string start))))
  string)
(defun ox-html-clear-single-linebreak-for-cjk (string backend info)
  (when (org-export-derived-backend-p backend 'html)
    (clear-single-linebreak-in-cjk-string string)))
(add-to-list 'org-export-filter-final-output-functions
             'ox-html-clear-single-linebreak-for-cjk)

(setq org-html-head "<link href=\"css/org-manual.css\" rel=\"stylesheet\" type=\"text/css\">")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; setting export the org-file to pdf,copied from others
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 使用xelatex一步生成PDF，不是org-latex-to-pdf-process这个命令
(setq org-latex-pdf-process
      '(
	"xelatex -interaction nonstopmode -output-directory %o %f"
	"xelatex -interaction nonstopmode -output-directory %o %f"
	"xelatex -interaction nonstopmode -output-directory %o %f"
	"rm -fr %b.out %b.log %b.tex auto"
	))
   
;;; 增加这个class
(add-to-list 'org-latex-classes '("ctexart" "\\documentclass[11pt]{ctexart}
[NO-DEFAULT-PACKAGES]
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage[colorlinks,linkcolor=blue,anchorcolor=black,citecolor=black]{hyperref}
\\usepackage[a4paper,left=2cm,right=2cm,top=2cm,bottom=3cm]{geometry}
\\tolerance=1000
"
				  ("\\section{%s}" . "\\section*{%s}")
				  ("\\subsection{%s}" . "\\subsection*{%s}")
				  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
				  ("\\paragraph{%s}" . "\\paragraph*{%s}")
				  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;;; 设置默认的class为ctexart
(setq org-latex-default-class "ctexart")
