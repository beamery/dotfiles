;; Set up org-mode ;;

;; org-mode customizations
(setq org-directory "~/Dropbox/org")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org")
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; org-mode capture templates
(setq org-capture-templates
  '(("a" "Action" entry (file+headline "~/Dropbox/org/gtd.org" "Inbox")
     "* TODO %?\n CREATED: %U\n %i")
    ("t" "Thought" entry (file+headline "~/Dropbox/org/gtd.org" "Inbox")
     "* %?\n CREATED: %U\n %i")
    ("n" "Note" entry (file+headline "~/Dropbox/org/journal.org" "Notes")
     "* %?\n CREATED: %U\n %i")
    ("j" "Journal" entry (file+datetree "~/Dropbox/org/journal.org")
     "* %?\n %i")
    ("k" "Tickler" entry (file+headline "~/Dropbox/org/tickler.org" "Tickler")
     "* %?\n CREATED: %U\n")))

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 2)
                                 (org-agenda-files :maxlevel . 2))))

(provide 'org-config)
