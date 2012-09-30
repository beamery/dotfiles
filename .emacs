(require 'package)
(add-to-list 'package-archives
	                  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(ido-mode (quote both) nil (ido))
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/Dropbox/org/gtd.org")))
 '(org-mobile-directory "~/Dropbox/MobileOrg")
 '(org-mobile-files (quote (org-agenda-files "~/Dropbox/org/")))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/config")

(package-initialize)
(load-theme 'solarized-dark t)

;; Load external config files
(load "org-config.el")
(load "custom-keybindings.el")
