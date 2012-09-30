;; org-mode customizations
(setq org-directory "~/Dropbox/org")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org")
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(provide 'org-config)
