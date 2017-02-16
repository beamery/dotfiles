;; Set up org-mode ;;

;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
;;(setq org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org")
;; Set to <your Dropbox root directory>/MobileOrg.
;;(setq org-mobile-directory "~/Dropbox/MobileOrg")

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; org-mode capture templates
(setq org-capture-templates
  '(("a" "Action" entry (file+headline "~/org/gtd.org" "Inbox")
     "* TODO %?\n CREATED: %U\n %i")
    ("t" "Thought" entry (file+headline "~/org/gtd.org" "Inbox")
     "* %?\n CREATED: %U\n %i")
    ("n" "Note" entry (file+headline "~/org/notes.org" "Notes")
     "* %?\n CREATED: %U\n %i")
    ("s" "Status" entry (file+datetree "~/org/notes.org")
     "* %?\n %i")
    ("k" "Tickler" entry (file+headline "~/org/tickler.org" "Tickler")
     "* %?\n CREATED: %U\n")
    ("p" "Project" entry (file+headline "~/org/gtd.org" "Projects")
     "* %^{name}\n :PROPERTIES:\n :CATEGORY: %\\1\n :END:\n")))

;; Targets include this file and any file contributing to the agenda
(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))

;; Make clocked times persist between sessions
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-hide-leading-stars t)

(provide 'org-config)
