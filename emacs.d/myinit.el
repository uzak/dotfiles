(setq inhibit-startup-screen t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-display-line-numbers-mode)
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)
(global-set-key (kbd "<f5>") 'revert-buffer)

;(global-hl-line-mode t)

(setq save-interpgoram-paste-before-kill t)

(defalias 'list-buffers 'ibuffer)
; shift + cursor keys for moving in windows
(windmove-default-keybindings)

(load "server")
(unless (server-running-p) (server-start))

;(use-package org-bullets
;    :ensure t
;    :config
;    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
    
; C-c C-x - (insert timer item); next M-return

;(custom-set-variables
;'(org-directory "/martinuzak")
;'(org-startup-indented t)
;)

(use-package evil :ensure t)
(evil-mode t)

;(use-package evil-org
;  :ensure t
;  :after org
;  :config
;  (add-hook 'org-mode-hook 'evil-org-mode)
;  (add-hook 'evil-org-mode-hook
;            (lambda ()
;              (evil-org-set-key-theme)))
;  (require 'evil-org-agenda)
;  (evil-org-agenda-set-keys))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;(use-package zenburn-theme
  ;:ensure t)
;(load-theme 'zenburn t)
;(load-theme 'solarized-light)
(load-theme 'leuven t)

;(use-package solarized-theme
  ;:ensure t
  ;:config
  ;(setq solarized-use-variable-pitch nil)
  ;(setq solarized-scale-org-headlines nil)
  ;(load-theme 'solarized-light t))
  ;
;(use-package smart-mode-line
  ;:ensure t
  ;:config
  ;(setq sml/theme 'dark)
  ;(setq sml/no-confirm-load-theme t)
  ;(sml/setup))

; highglihgt cursor
;(use-package beacon
;:ensure t
;:config 
;(beacon-mode 1))

; Shortcut: C-;
; M-x narrow-to-region
; M-x widen

; http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
(defun narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first. Narrowing to
org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning)
                           (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if
         ;; you don't want it.
         (cond ((ignore-errors (org-edit-src-code) t)
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

;(define-key endless/toggle-map "n"
  ;#'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing
;; keymap, that's how much I like this command. Only
;; copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)
;(add-hook 'LaTeX-mode-hook
          ;(lambda ()
            ;(define-key LaTeX-mode-map "\C-xn"
              ;nil)))


(use-package iedit
:ensure t)

; delete all whitespaces
(use-package hungry-delete
:ensure t
:config)

(use-package expand-region
:ensure t
:config
(global-set-key (kbd "C-=") 'er/expand-region))

(use-package try
             :ensure t)
	     
(use-package markdown-mode
     :ensure t)

(use-package which-key
    :ensure t
    :config
    (which-key-mode))

;; this or helm
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

(use-package counsel
  :ensure t
  :defer t
  :bind (
  ("M-y" . counsel-yank-pop)
  :map ivy-minibuffer-map
  ("M-y" . ivy-next-line)))
  
(use-package ivy
:ensure t
:diminish (ivy-mode)
:bind (("C-x b" . ivy-switch-buffer))
:config
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-display-style 'fancy))
  
 (use-package swiper
   :ensure t
   :config
   (progn
     (ivy-mode 1)
 (setq ivy-use-virtual-buffers t)
 (setq enable-recursive-minibuffers t)
 ;; enable this if you want `swiper' to use it
 ;; (setq search-default-mode #'char-fold-to-regexp)
     (global-set-key "\C-s" 'swiper)
     (global-set-key (kbd "C-c C-r") 'ivy-resume)
     ;(global-set-key (kbd "<f6>") 'ivy-resume)
     (global-set-key (kbd "M-x") 'counsel-M-x)
     (global-set-key (kbd "C-x C-f") 'counsel-find-file)
     ;(global-set-key (kbd "C-c g") 'counsel-git)
     ;(global-set-key (kbd "C-c j") 'counsel-git-grep)
     ;(global-set-key (kbd "C-c k") 'counsel-ag)
     ;(global-set-key (kbd "C-x l") 'counsel-locate)
     ;(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
     ))

;(use-package swiper
  ;:ensure t
  ;:commands swiper
  ;:bind ("C-s" . counsel-grep-or-swiper)
  ;:config
  ;(require 'counsel)
  ;(setq counsel-grep-base-command "grep -niE \"%s\" %s")
  ;(setq ivy-height 20))

(use-package ox-reveal
    :ensure ox-reveal)

(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-mathjax t)

(use-package htmlize
    :ensure t)

(use-package flycheck
    :ensure t
    :init
    (global-flycheck-mode t))

(use-package jedi
    :ensure t
    :init
    (add-hook 'python-mode-hook 'jedi:setup)
    (add-hook 'python-mode-hook 'jedi:ac-setup))
    
; for documentation (C-c C-d)
(use-package elpy
    :ensure t
    :config (elpy-enable))

; also do: M-x jedi:install-server

(use-package yasnippet
    :ensure t
    :init (yas-global-mode 1))

(use-package yasnippet-snippets
    :ensure t
    :defer t)

(use-package undo-tree
    :ensure t
    :init 
    (global-undo-tree-mode))

;(load-file "something.el")
(defun load-if-exists (f)
"load the elisp file if it exists and is readable"
  (if (file-readable-p f)
      (load-file f)))

(use-package web-mode
:ensure t
:config
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
'(("django"    . "\\.html\\'")))
(setq web-mode-ac-sources-alist
'(("css" . (ac-source-css-property))
("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-quoting t)) ; this fixes the quote problem I mentioned
