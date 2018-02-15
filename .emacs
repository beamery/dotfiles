;; Google-specific setup
(require 'google)
(require 'citc)
(require 'google-java-format)

;; set up paths
(add-to-list 'load-path "~/.emacs.d/plugin")
(add-to-list 'load-path "~/.emacs.d/evil")

;; initialize package management
(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; setup Evil
(setq evil-want-C-i-jump nil) ;; Make Evil TAB key work in org mode.
(require 'evil)
(require 'undo-tree)
(evil-mode 1)
(setq evil-insert-state-cursor 'box)

;; set up Evil keybindings
(define-key evil-normal-state-map ",b" 'ido-switch-buffer)
(define-key evil-normal-state-map ",f" 'ido-find-file)
(define-key evil-normal-state-map ",w" 'other-window)
(define-key evil-normal-state-map ",x" 'smex)
(define-key evil-normal-state-map ",q" 'fill-paragraph)
(define-key evil-normal-state-map ",0" 'delete-window)
(define-key evil-normal-state-map ",1" 'delete-other-windows)
(define-key evil-normal-state-map ",2" 'split-window-vertically)
(define-key evil-normal-state-map ",3" 'split-window-horizontally)
(define-key evil-normal-state-map ",3" 'split-window-horizontally)

;; set up IDO mode
(setq ido-enale-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

;; set up Markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
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
 '(compilation-error-regexp-alist
   (quote
    (google3-build-log-parser-info google3-build-log-parser-warning google3-build-log-parser-error google-blaze-error google-log-error google-log-warning google-log-info google-log-fatal-message google-forge-python gunit-stack-trace absoft ada aix ant bash borland python-tracebacks-and-caml comma cucumber msft edg-1 edg-2 epc ftnchek iar ibm irix java jikes-file maven jikes-line clang-include gcc-include ruby-Test::Unit gnu lcc makepp mips-1 mips-2 msft omake oracle perl php rxp sparc-pascal-file sparc-pascal-line sparc-pascal-example sun sun-ada watcom 4bsd gcov-file gcov-header gcov-nomark gcov-called-line gcov-never-called perl--Pod::Checker perl--Test perl--Test2 perl--Test::Harness weblint guile-file guile-line)))
 '(custom-safe-themes
   (quote
    ("b67cb8784f6a2d1a3f605e39d2c376937f3bf8460cb8a0d6fc625c0331c00c83" "858a353233c58b69dbe3a06087fc08905df2d8755a0921ad4c407865f17ab52f" "82fce2cada016f736dbcef237780516063a17c2436d1ee7f42e395e38a15793b" "8e4efc4bed89c4e67167fdabff77102abeb0b1c203953de1e6ab4d2e3a02939a" default)))
 '(menu-bar-mode nil)
 '(org-agenda-files
   (quote
    ("~/org/tickler.org" "~/org/gtd.org" "~/org/birthday.org")))
 '(package-selected-packages (quote (gruvbox-theme yasnippet smex)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set up color theme ;;
(setq evil-default-cursor t) ;; Now evil takes the default colors
;;(load-theme 'deeper-blue)
(load-theme 'wombat)
;; Hack that gives me a zenburn color theme for ansi-term
(setq ansi-term-color-vector
      [unspecified "#3f3f3f" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"])

;; Load external config files
(add-to-list 'load-path "~/.emacs.d/config")
(load "org-config.el")
