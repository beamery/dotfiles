;; set up paths
(add-to-list 'load-path "~/.emacs.d/plugin")
(add-to-list 'load-path "~/.emacs.d/evil")

;; initialize package management
(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; setup Evil
(require 'undo-tree)
(require 'evil)
(evil-mode 1)
(setq evil-insert-state-cursor 'box)

;; set up Evil keybindings
(define-key evil-normal-state-map ",b" 'ido-switch-buffer)
(define-key evil-normal-state-map ",f" 'ido-find-file)
(define-key evil-normal-state-map ",w" 'other-window)
(define-key evil-normal-state-map ",x" 'smex)
(define-key evil-normal-state-map ",0" 'delete-window)
(define-key evil-normal-state-map ",1" 'delete-other-windows)
(define-key evil-normal-state-map ",2" 'split-window-vertically)
(define-key evil-normal-state-map ",3" 'split-window-horizontally)

;; set up IDO mode
(setq ido-enale-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

;; set up Markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; set up yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
            '("~/.emacs.d/snippets"            ;; personal snippets
	      "~/.emacs.d/elpa/yasnippet-0.8.0/snippets" ;; the default collection
	     ))

(yas-global-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
