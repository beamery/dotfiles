;; org-mode customizations
(setq org-directory "~/Dropbox/org")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org")
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
'(org-capture-templates '(("t" "Task" entry (file+headline "~/Dropbox/org/gtd.org" "Inbox")
				  "* TODO %?\n CREATED: %U\n %i")
			   ("e" "General Entry" entry (file+headline "~/Dropbox/org/gtd.org" "Inbox") 
			   "* %?\n CREATED: %U\n %i")))

'(org-refile-targets  '(("gtd.org" :maxlevel . 3) 
                              ("someday.org" :level . 2)))

(provide 'org-config)
