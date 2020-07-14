;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font "Hack-12"
      doom-variable-pitch-font "Fira Sans" ; inherits `doom-font''s :size
      doom-serif-font "Fira Code"
      doom-unicode-font "Symbola";; "Input Mono"
      doom-big-font "Hack-19")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-two)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Better dotnet Projectile support
(add-load-path! (expand-file-name "packages" doom-private-dir))
(after! projectile (require 'projectile+))

;; FSharp
(after! lsp-mode
  (setq fsharp2-lsp-executable
        (if IS-WINDOWS
            "E:/Repos/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp3.0/win10-x64/FSharpLanguageServer.exe"
          "~/src/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp3.0/linux-x64/FSharpLanguageServer"))

  ;; Required to avoid issues with lsp-mode's built-in F# client; even though
  ;; we're using our mode instead, lsp-mode can't build the LSP client
  ;; without this value defined
  (setq lsp-fsharp-server-path "")

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection fsharp-lsp-executable)
    :major-modes '(fsharp-mode)
    :server-id 'fsharp-lsp
    :notification-handlers (ht ("fsharp/startProgress" #'ignore)
                               ("fsharp/incrementProgress" #'ignore)
                               ("fsharp/endProgress" #'ignore))
    :priority 1)))

;; winum
;;
;; Use a Spacemacs-y.  Rebind M-0 -- M-9 to switch windows.
(after! winum
  (setq winum-auto-assign-0-to-minibuffer nil
        winum-auto-setup-mode-line nil
        winum-ignored-buffers '(" *which-key*"))
  (define-key winum-keymap (kbd "M-0") 'winum-select-window-0-or-10)
  (define-key winum-keymap (kbd "M-1") 'winum-select-window-1)
  (define-key winum-keymap (kbd "M-2") 'winum-select-window-2)
  (define-key winum-keymap (kbd "M-3") 'winum-select-window-3)
  (define-key winum-keymap (kbd "M-4") 'winum-select-window-4)
  (define-key winum-keymap (kbd "M-5") 'winum-select-window-5)
  (define-key winum-keymap (kbd "M-6") 'winum-select-window-6)
  (define-key winum-keymap (kbd "M-7") 'winum-select-window-7)
  (define-key winum-keymap (kbd "M-8") 'winum-select-window-8)
  (define-key winum-keymap (kbd "M-9") 'winum-select-window-9))

;; Do my standard Dvorak remapping.
;;
;; I turn off evil-snipe mode to avoid having "s" and "S" bound to evil-snipe. I
;; can't seem to figure out how to change the binding that is done by that mode,
;; but then I rebind k/K to have the same behavior.
(after! evil-snipe (evil-snipe-mode -1))
(map! :nv "h" 'evil-backward-char
      :nv "H" 'evil-window-top
      :nv "t" 'evil-next-line
      :nv "T" 'evil-join
      :nv "n" 'evil-previous-line
      :nv "N" '+lookup/documentation
      :nv "s" 'evil-forward-char
      :nv "S" 'evil-window-bottom
      :nv "l" 'evil-ex-search-next
      :nv "L" 'evil-ex-search-previous

      ;; NOTE: These replacements are evil not vim bindings.
      :nv "j" 'evil-snipe-t
      :nv "J" 'evil-snipe-T
      :nv "k" 'evil-snipe-s
      :nv "K" 'evil-snipe-S)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-headerline-breadcrumb-enable t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'customize-group 'disabled nil)
(put 'customize-face 'disabled nil)
