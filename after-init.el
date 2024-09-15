;; AucTeX after init

(use-package tex
  :ensure auctex

  :requires (latex company)

  :mode ("\\.tex\\'" . LaTeX-mode)

  :config
  (use-package rainbow-delimiters)

  (use-package smartparens
    :diminish smartparens-mode ;; Do not show in modeline
    :init
    (require 'smartparens-config))

  ;; Indent items by two spaces.
  (setq LaTeX-item-indent 0)

  (setq TeX-PDF-mode t)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq LaTeX-math-menu-unicode t)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-PDF-mode t)
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-source-correlate-start-server t)

  (eval-after-load "tex"
    '(add-to-list 'TeX-command-list '("latexmk" "latexmk -synctex=1 -shell-escape -pdf %s" TeX-run-TeX nil t :help "Process file with latexmk")))
  (eval-after-load "tex"
    '(add-to-list 'TeX-command-list '("xelatexmk" "latexmk -synctex=1 -shell-escape -xelatex %s" TeX-run-TeX nil t :help "Process file with xelatexmk")))
  (add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))


  ;; Use pdf-tools to open PDF files
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-source-correlate-start-server t
        TeX-source-correlate-method 'synctex)

  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (rainbow-delimiters-mode)
              (company-mode)
              (smartparens-mode)
              (turn-on-reftex)
              (LaTeX-math-mode)
              (reftex-isearch-minor-mode)
              (flyspell-mode)
              (visual-line-mode)))


  ;; Update PDF buffers after successful LaTeX runs
  (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
            #'TeX-revert-document-buffer)

  ;; to use pdfview with auctex
  (add-hook 'LaTeX-mode-hook #'pdf-tools-install)


  (add-hook 'LaTeX-mode-hook
            '(lambda ()
               (reftex-mode))))
