 ;;; emacs --- Summary
;;; Commentary:

;;; Code:

;; ****************************************************************
;; Managing packages
;; ****************************************************************

(require 'package)

(add-to-list 'package-archives
			 '("MELPA" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;;; ****************************************************************
;;; Basic emacs config
;;; ****************************************************************

(use-package gradle-mode
  :ensure t)

(column-number-mode)
;;(global-display-line-numbers-mode t)

;; Some modes don't need line numbers
(dolist (mode '(term-mode-hook eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

;;; ****************************************************************
;;; The AI is coming to take our jobs
;;; ****************************************************************

;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 6))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))

;; (straight-use-package
;;  '(copilot :host github :repo "zerolfx/copilot" :files ("dist" "*.el")))

;; 'copilot
;;   (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
;;   :ensure t)

;; (add-hook 'prog-mode-hook 'copilot-mode)

;;; ****************************************************************
;;; Programming font - hat-tip to @Graham Trogdon!
;;; ****************************************************************

(set-face-attribute 'default nil :font "Fira Code" :height 150)

;; (use-package ligature
;;   :ensure t)

;; ;; WWW ligature everywhere all the time
;; (ligature-set-ligatures 't '("www"))

;; ;; Enable ligatures in programming modes (see github.com/tonsky/FiraCode/wiki/Emacs-instructions)
;; (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*/" "\\\\"
;;									 "!!" "!=" "!==" "----" "-->" "->"
;;									 "##" "###" "####"
;;									 "..." "?=" "??" ";;" "/*" "/**"
;;									 "/=" "/==" "/>" "//" "///" "&&" "||"
;;									 "++" "==" "===" "==>" "=>" "<="
;;									 ">="
;;									 "<!--" "<-" "<--" "<->"
;;									 "<=" "<==" "<=>" "%%"))
;; (global-ligature-mode 't)

;;Figure out how to use dired with the assistance of the "discover" package
(use-package discover
  :ensure t
  :config (global-discover-mode 1))

;;; ****************************************************************
;;; This magic is needed to get the path for spawned processes to work correctly
;;; ****************************************************************

(use-package exec-path-from-shell
 :if (memq window-system '(mac ns))
 :ensure t
 :init
 (exec-path-from-shell-initialize)
 (ns-toggle-toolbar)
 )

;;; Tell Emacs to skip using a tiny cursor even though I have JAWS installed
(setq-default cursor-type 'box)

;;; You always want to know where the matching paren is
(show-paren-mode 1)

;;; And how wildly nested your line is
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;;; But you don't really need scrollbars
(scroll-bar-mode -1)

;; Focus on the current active section of text
(use-package focus
  :ensure t)

;; And try to keep track of where the cursor is
(use-package beacon
  :ensure t
  :config (beacon-mode 1))

(defun open-index-html ()
  "Open the index.html file for local httpd."
 (interactive)
 (find-file "/opt/homebrew/var/www/index.html"))

;;; Random stuff that doesn't fit anywhere else
(put 'upcase-region 'disabled nil)
(global-set-key (kbd "C-x C-g") 'goto-line)
(global-set-key (kbd "C-x x") 'next-error)
(global-set-key (kbd "C-;") 'comment-region)
(global-set-key (kbd "C-x j") 'join-line)
(global-set-key (kbd "C-c v") 'browse-url-of-file)

(setq inhibit-startup-screen t)
(setq frame-inhibit-implied-resize t)
;
;;; No need for that new-fangled icon stuff wasting space
(tool-bar-mode 0)
;
;;; Set the default window size, based on experimentation with my current monitor
(eval-after-load
	'.emacs
 (when window-system
   (set-frame-size (selected-frame) 1899 930 t)
   (set-frame-position (selected-frame) 0 0)
	)
  )

;(defun make-accessors (type rawProp)
;  "Create a get/set pair of accessors."
;  (interactive "sType: \nsProperty: ")
;  (let ((prop (capitalize rawProp)))
;	(insert (mapconcat
;			 'identity
;			 (list
;				"/**"
;				(concat "* " rawProp)
;				(concat "* @type {" type "}")
;				"* @public"
;				"*/"
;				(concat "get " rawProp "() {")
;				(concat "return this._" rawProp ";")
;				"}"
;				""
;				(concat "set " rawProp "(new" prop ") {")
;				"const isValid = (candidate) => {"
;				"return false;"
;				"};"
;				(concat "if (assert.ok(isValid(new" prop"), '" rawProp " is invalid')) {")
;				(concat "this._" rawProp "= new" prop ";")
;				"}"
;				"}") "\n"
;				)
;			)
;	)
;  )
;
;;; ****************************************************************
;;; File cache
;;; ****************************************************************
;
;(defconst a11yCat-root "~/A11Y/a11ycat")
;(defconst special-root "~/A11Y/special-projects/design/graiai/api")

(defconst sga-root "~/A11Y/sga/")
(defconst graiai-root "~/A11Y/graiai/titan/")
(defconst graiai-proj (concat graiai-root "libs/graiai"))
(defconst graiai-i18n-proj (concat graiai-root "libs/graiai-i18n"))
(defconst perseus-proj (concat graiai-root "apps/perseus"))
(defconst hatchet-root "~/A11Y/hatchet/")
(defconst hatchet-commons (concat hatchet-root "hatchet-commons"))
(defconst hatchet-chrome (concat hatchet-root "hatchet-chrome"))
(defconst jira-tool "~/A11Y/jira-reporting-tool")
(defconst vpat-manager "~/A11Y/vpat-manager/")

(defun flatten-list (l)
  "Flatten a nested list L."
 (cond
  ((null l) nil)
  ((atom l) (list l))
  (t (append (flatten-list (car l)) (flatten-list (cdr l))))
  )
 )

(defun add-src-and-test (path)
  "Add /src and /test to the given PATH."
 (list (concat path "/src") (concat path "/test")))

(defconst sga-dirs (concat sga-root "tests")
  "Directories with source for the SAS Graphics Accelerator project")

(defconst graiai-dirs
  (mapcar #'add-src-and-test
		  (list graiai-proj graiai-i18n-proj perseus-proj))
  "Directories with source for Graiai and Perseus")

(defconst hatchet-dirs
  (mapcar #'add-src-and-test
		  (list hatchet-commons hatchet-chrome))
  "Directories with source for the various flavors of Hatchet")

(defconst vpat-manager-dirs
   (list (concat vpat-manager "config")
		 (concat vpat-manager "database")
		 (concat vpat-manager "ddl")
		 (concat vpat-manager "deployments")
		 (concat vpat-manager "handlers")
		 (concat vpat-manager "models")
		 (concat vpat-manager "scripts")
		 (concat vpat-manager "structs")
		 (concat vpat-manager "templates")
		 (concat vpat-manager "test")
		 (concat vpat-manager "validation"))
   "Directories with source for VPAT Manager")

(defconst interesting-dirs
  (flatten-list
   (list vpat-manager-dirs graiai-dirs))
  "All source directories scanned by the filecache code")

(require 'time-stamp)

(defun load-cache ()
 "Load the directory cache."
 (interactive)

 ;; Chicken and egg - does not exist the first time
 ;; through because we have not loaded the cache code yet
 (if (functionp 'file-cache-clear-cache)
     (progn
	(message "Clearing file cache...")
	(file-cache-clear-cache)))

 (message "Loading file cache...")
 (dolist (d interesting-dirs)
   (message "%s: Processing %s" (time-stamp-string) d)
   (if (file-directory-p d)
	(file-cache-add-directory-using-find d)
     (message "Directory not found %s" d)))
 (message "Done with file cache")
 )

(use-package filecache
  :init
  (load-cache)

  :config
  (define-key minibuffer-local-map [backtab] 'file-cache-minibuffer-complete)
  )

;;; ****************************************************************
;;; Whitespace
;;; ****************************************************************
(use-package whitespace
 :ensure t

 :init
 (global-whitespace-mode t)

 :custom
 (indent-tabs-mode t)
 (c-basic-offset 4)
 (tab-width 4)
 (standard-indent 4)
;; (whitespace-action '(auto-cleanup))
 (whitespace-linecolumn 132)
 (whitespace-style
  '(face empty newline newline-mark space-after-tab space-before-tab trailing))
)

;;; ****************************************************************
;;; Golang editing
;;; ****************************************************************
(use-package go-mode
  :config (use-package godoctor))
(add-hook 'go-mode-hook (lambda()
						  (add-hook 'before-save-hook #'gofmt-before-save)))

;;; ****************************************************************
;;; Javascript editing
;;; ****************************************************************
;
;(fset 'no-jsdoc
;   [?\C-o tab ?/ ?/ ?  ?e ?s ?l ?i ?n ?t ?- ?d ?i ?s ?a ?b ?l ?e ?- ?n ?e ?x ?t ?- ?l ?i ?n ?e ?  ?j ?s ?d ?o ?c ?/ ?r ?e ?q ?u ?i ?r ?e ?- ?j ?s ?d ?o ?c])
;
;(fset 'allow-literal-string
;   [?\C-a ?\C-o tab ?/ ?/ ?  ?e ?s ?l ?i ?n ?t ?- ?d ?i ?s ?a ?b ?l ?e ?- ?n ?e ?x ?t ?- ?l ?i ?n ?e ?  ?i ?1 ?8 ?n ?e ?x ?t ?/ ?n ?o ?- ?l ?i ?t ?e ?r ?a ?l ?- ?s ?t ?r ?i ?n ?g ?\C-n ?\C-n])
;
(use-package typescript-mode
 :ensure t
 :mode "\\.tsx?\\'"
 )

(use-package js2-mode
 :ensure t
 :mode "\\.[cm]?js\\'"
 :config
 (setq js2-highlight-level 3)

 :custom (js2-global-externs (mapcar 'symbol-name '(jQuery sas sap QUnit assert)))

 :custom-face
 (js2-external-variable
  ((t (:foreground "black"
		:underline t
		:slant italic
		:weight bold))))

 (js2-function-param
  ((t (:foreground "dark green"))))

 (js2-warning
  ((t (:underline "orange red"))))
 )

(add-hook 'js2-mode-hook
         (lambda ()
			(when (or
					 (string-match-p "/tests?/.*\\.js$" (buffer-file-name))
					 (string-match-p "\\.spec\\.js$" (buffer-file-name))
					 ))))

;;; ****************************************************************
;;; Robot
;;; ****************************************************************
;(load-file "~/.emacs.d/robot-mode.el")
;(add-to-list 'auto-mode-alist '("\\.robot\\'" . robot-mode))
;
;;; ****************************************************************
;;; HTML and CSS
;;; ****************************************************************
;
(use-package css-mode
 :ensure t
 :mode "\\.less\\'"
 )

(use-package web-mode
 :ensure t
 :mode "\\.html?\\'"
 )

(add-to-list 'auto-mode-alist '("\\.gtml\\'" . nxml-mode))

;;; ****************************************************************
;;; Markdown
;;; ****************************************************************
;
(use-package markdown-mode
 :ensure t
 :config
 (auto-fill-mode)
)

;;; ****************************************************************
;;; JSON mode
;;; ****************************************************************

(use-package json-mode
 :ensure t
 :mode "\\.eslintrc\\'")

;;; Mode line enhancements
(use-package smart-mode-line
  :ensure t
  :init (progn
		  (setq sml/no-confirm-load-theme t)
		  (sml/setup)
		  (setq sml/theme 'light)))

;;; ****************************************************************
;;; Flycheck and lint
;;; ****************************************************************
;
;;; Needed to convince flycheck not to complain about its own functions in this file...
(declare-function flycheck-add-mode "flycheck" (checker mode))
;
;;; Typescript setup
(use-package tide :ensure t)

(use-package flycheck
			 :ensure t

			 :init
			 (global-flycheck-mode)
			 (flycheck-add-mode 'javascript-eslint 'js2-mode)
			 (setq flycheck-check-syntax-automatically '(save mode-enabled))

		 :custom
		 (flycheck-javascript-eslint-executable "/usr/local/bin/eslint")
		 (flycheck-checker-error-threshold 500)

		 :custom-face
		 (flycheck-color-mode-line-error-face
			((t
		(:inherit flycheck-fringe-error
				:background "red"
				:foreground "black"
				:weight normal))))
		 (flycheck-color-mode-line-warning-face
			((t
		(:inherit flycheck-fringe-warning
				:background "orange"
				:foreground "black"
				:weight normal))))

			 :config
		 (setq-default flycheck-disabled-checkers
				 (append flycheck-disabled-checkers '(javascript-jshint tsx-tide typescript-tide)))
		 :hook (flycheck-mode . flycheck-color-mode-line-mode)
			 )

;;; Put flycheck errors in a popup window
(use-package flycheck-pos-tip
 :ensure t
 :init (flycheck-pos-tip-mode))

(use-package flycheck-color-mode-line
 :ensure t
 )

(defun setup-tide-mode ()
  "Launch the tide mode."
 (interactive)
 (tide-setup)
 (flycheck-mode +1)
 (eldoc-mode +1)
 (tide-hl-identifier-mode +1)
)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
         (lambda ()
           (when (string-equal "tsx" (file-name-extension buffer-file-name))
             (setup-tide-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LaTeX support
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package tex
  :ensure auctex)
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; Spell checking (see https://www.tenderisthebyte.com/blog/2019/06/09/spell-checking-emacs/)
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(eval-after-load "flyspell"
  '(progn
	 (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
	 (define-key flyspell-mouse-map [mouse-3] #'undefined)))

;;; enable typescript - tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)
;
;;; End of Typescript setup
;
;(custom-set-variables
; ;; custom-set-variables was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; '(flycheck-javascript-eslint-executable "/usr/local/bin/eslint")
; '(indent-tabs-mode t nil nil "Customized with use-package whitespace")
; '(js2-global-externs '("jQuery" "sas" "sap" "QUnit" "assert"))
; '(js2-ignored-warnings (list "msg.no.side.effects"))
; '(package-selected-packages
;   '(edit-indirect prettier robot-mode robots-txt-mode prettier-js yaml-mode xref-js2 xml-rpc ws-butler web-mode use-package tide skewer-mode mediawiki markdown-mode json-mode js2-refactor groovy-mode gradle-mode flycheck-pos-tip flycheck-color-mode-line expand-region exec-path-from-shell eslint-fix editorconfig discover-my-major company auto-package-update auto-complete))
; '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :background "red" :foreground "black" :weight normal))))
; '(flycheck-color-mode-line-warning-face ((t (:inherit flycheck-fringe-warning :background "orange" :foreground "black" :weight normal))))
;
;
;
(use-package prettier :ensure t)
(add-hook 'after-init-hook #'global-prettier-mode)

(use-package handlebars-mode
  :ensure t
  :mode "\\.hbs\\'")

(use-package feature-mode
  :ensure t
  : mode "\\.feature")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-item-indent 0)
 '(column-number-mode t)
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))
 '(org-agenda-files '("~/A11Y/vpat-manager/foo.org"))
 '(package-selected-packages
   '(feature-mode godoctor edit-indirect solarized-theme handlebars-mode minimap selectric-mode pdf-tools js2-refactor smart-mode-line beacon discover ligature focus all-the-icons rainbow-delimiters doom-modeline xkcd web-mode use-package typescript-mode tide prettier markdown-mode json-mode js2-mode groovy-mode gradle-mode go-mode flycheck-pos-tip flycheck-color-mode-line exec-path-from-shell auto-package-update auctex))
 '(split-height-threshold 40)
 '(tool-bar-mode nil)
 '(warning-suppress-types '((use-package) (use-package) (use-package))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#000000" :foreground "#ffffff" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Menlo")))))

(defun delete-to-next-uppercase ()
  "Delete from point to the next uppercase letter."
  (interactive)
  (save-excursion
	(let ((start (point))
		  end
		  (cfs case-fold-search))
	  (setq case-fold-search nil)
	  (setq end (search-forward-regexp "[A-Z]" (line-end-position) t))
	  (if (numberp end)
		  (delete-region start (1- end))
		)
	  (setq case-fold-search cfs)
	  )))

(global-set-key (kbd "C-c c") 'delete-to-next-uppercase)

;; Pick a font size I can actually read.


;;; ****************************************************************
;;; MCP: End of Line
;;; ****************************************************************

(provide '.emacs)
;;; .emacs ends here
