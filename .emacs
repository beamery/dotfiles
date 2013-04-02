
;; setup Evil
(add-to-list 'load-path "~/.emacs.d/plugin")
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'undo-tree)
(require 'evil)
(evil-mode 1)

;; setup IDO mode
(setq ido-enale-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
