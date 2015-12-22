;;; init-personal-setting.el --- personal settings
;;; Commentary:
;;个性化设置
;;; Code:

;;------------------------------------------------------------------------------------------
;;C-c fx,x是任意一个字符,光标就会移动到下一个"x"处
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
                     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
;;------------------------------------------------------------------------------------------
;;这里注意,必须在一个hook里面完成,使用lambda表达式
(add-hook 'prog-mode-hook
          (lambda ()
            (hs-minor-mode t);;开启hs-minor-mode
            (define-key hs-minor-mode-map (kbd "C-/ H") 'hs-hide-all)
            (define-key hs-minor-mode-map (kbd "C-/ S") 'hs-show-all)
            (define-key hs-minor-mode-map (kbd "C-/ h") 'hs-hide-block)
            (define-key hs-minor-mode-map (kbd "C-/ s") 'hs-show-block)
            (define-key hs-minor-mode-map (kbd "C-/ l") 'hs-hide-level)
            (define-key hs-minor-mode-map (kbd "C-/ t") 'hs-toggle-hiding)
            ))
;;------------------------------------------------------------------------------------------
;;(menu-bar-mode -1);去掉菜单栏
;;------------------------------------------------------------------------------------------
;;shell 清屏
(defun my-clear ()
  "When you are in shell-mode, you can press Ctrl-l to clear the screen."
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
(defun my-shell-hook ()
  "Provide my-shell-hook for you, it will be used to clear the screen in shell mode."
  (local-set-key "\C-cl" 'my-clear))
(add-hook 'shell-mode-hook 'my-shell-hook)
;;------------------------------------------------------------------------------------------
;;防止页面滚动时跳动
;;scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动
;;scroll-step 1 设置为每次翻滚一行，可以使页面更连续
(setq scroll-step 1 scroll-margin 3 scroll-conservatively 10000)
;; 当光标在行尾上下移动的时候，始终保持在行尾。
(setq track-eol t)
;;------------------------------------------------------------------------------------------
;;set transparent effect
(global-set-key [(f9)] 'loop-alpha)
(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))
(defun loop-alpha ()
  "Press f9, and you can set transparent effect."
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
  )
;;------------------------------------------------------------------------------------------
;;增强'M-;'的注释功能
;;光标位于行尾时，'M-;'在行尾进行注释；
;;当光标位于其他位置时，'M-;'起到注释该行的作用；
;;当选中一部分区域时，'M-;'起到注释该区域的作用。
(defun qiang-comment-dwim-line (&optional arg)
  "Improve the function of \"Metal-;\"(as ARG)."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
;;------------------------------------------------------------------------------------------
;;C-z跳到行中间
(defun middle-of-line ()
  "Put cursor at the middle point of the line."
  (interactive)
  (goto-char (/ (+ (point-at-bol) (point-at-eol)) 2)))

;;-----------------------------------------------------------------------------------------
;;C-w直接删除整行，M-w在不事先选中整行的情况下复制整行
(defadvice kill-ring-save (before slickcopy activate compile)
  "Improve the function of Metal-w."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
  "Improve the function of Ctrl-w."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))
;;------------------------------------------------------------------------------------------
;;加载快捷键
(require 'keybind)
;;------------------------------------------------------------------------------------------
(provide 'init-personal-setting)
;;; init-personal-setting.el ends here
