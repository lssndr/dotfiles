;;                  EMACS configs
;;
;;                ::::::::::::::::                
;;            :::::::MMMMMMMMMMM:::::             
;;         :::::::::::::MMMMMMMMMMMM::::          
;;       :::::::::::::MMMMMMMMMMM:::::::::        
;;      :::::::::::MMMMMMMMMMMMMMM::::::::::      
;;    ::::::::::::MMMMMMMMMMMMMMMMMM::::::::::    
;;   :::::::::::MMMMMMMMM::::::::::::::::::::::   
;;   :::::::::::MMMMMMMMMMM::::::::::::::::::::   
;;  :::::::::::::MMMMMMMMMMM::::::::::::::::::::  
;;  :::::::::::::::MMMMMMMMMM:::::::::::::::::::  
;;  :::::::::::::MMMMMMMMMMMMM::::::::::::::::::  
;;  :::::::::::MMMMMMMMMMMM:::::::::::::::::::::  
;;  :::::::::MMMMMMMMM::::::::::::::::::::::::::  
;;  ::::::::MMMMMMMM::::::::::::::::::::::::::::  
;;   :::::::MMMMMMMM:::::::::::::::::::::::::::   
;;    :::::::MMMMMMMMMMMMMMMMMMMMMMMMMMM::::::    
;;     ::::::::::::MMMMMMMMMMMMMMMMMMMM::::::     
;;       :::::::::::::MMMMMMMMMMMMMM:::::::       
;;         :::::::MMMMMMMMMMMM:::::::::::         
;;           ::::::::::::::::::::::::::           
;;               ::::::::::::::::::

;; Custom settings
(custom-set-variables
  '(blink-cursor-mode nil)
  '(default-frame-alist '((vertical-scroll-bars) (width . 100) (height . 35)))
  '(menu-bar-mode nil)
  '(package-selected-packages '(telephone-line nord-theme ivy drag-stuff))
  '(scroll-bar-mode nil)
  '(tool-bar-mode nil))

;; Custom faces
(custom-set-faces
  '(whitespace-big-indent ((t (:foreground "lightgray"))))
  '(whitespace-empty ((t (:foreground "lightgray"))))
  '(whitespace-hspace ((t (:foreground "lightgray"))))
  '(whitespace-indentation ((t (:foreground "lightgray"))))
  '(whitespace-line ((t (:foreground "lightgray"))))
  '(whitespace-space ((t (:foreground "lightgray"))))
  '(whitespace-space-after-tab ((t (:foreground "lightgray"))))
  '(whitespace-space-before-tab ((t (:foreground "lightgray"))))
  '(whitespace-tab ((t (:foreground "lightgray"))))
  '(whitespace-trailing ((t (:foreground "lightgray")))))


;; Store autosave/backup files in ~/.emacs.d/
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

(make-directory "~/.emacs.d/autosaves/" t)

;; Backups limit
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; Melpa repository 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Packages
(setq my-packages
      '(ivy
        drag-stuff
        nord-theme
        telephone-line))

(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; Enable Ivy
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; Nord theme
(load-theme 'nord t)

;; Highlight matching parentheses
(show-paren-mode 1)

;; Enable telephone-line status bar
(telephone-line-mode 1)

;; Move lines/regions (using drag-stuff)
(drag-stuff-global-mode t)
(drag-stuff-define-keys)

;; Windows switching (using shift+arrows)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Custom bindings
(global-set-key (kbd "C-x q") 'kill-current-buffer)
(global-set-key (kbd "C-x w") 'global-whitespace-mode)
(global-set-key (kbd "<C-tab>") 'switch-to-next-buffer)
(global-set-key (kbd "<C-iso-lefttab>") 'switch-to-prev-buffer)
