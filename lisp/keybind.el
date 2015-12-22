;;; keybind.el --- provide short-key
;;; Commentary:
;;; Code:
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;--------------------------------------------------
;类似vi的fc功能
(define-key global-map (kbd "C-c f") 'wy-go-to-char)
;;------------------------------------------------------------------------------------------
(global-set-key [f1] 'shell)
;;------------------------------------------------------------------------------------------
;;s-n连续下跳5行
(global-set-key (kbd "s-n")
                (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "s-p")
                (lambda () (interactive) (previous-line 5)))
;;------------------------------------------------------------------------------------------
;;优化注释功能
(global-set-key "\M-;" 'qiang-comment-dwim-line)
;;------------------------------------------------------------------------------------------
;;跳到行中间
(global-set-key (kbd "C-z") 'middle-of-line)
;;------------------------------------------------------------------------------------------
(global-set-key (kbd "s-h") 'tabbar-backward-group)
(global-set-key (kbd "s-l") 'tabbar-forward-group)
(global-set-key (kbd "s-j") 'tabbar-backward)
(global-set-key (kbd "s-k") 'tabbar-forward)
;;------------------------------------------------------------------------------------------
(provide 'keybind)
;;; keybind.el ends here
