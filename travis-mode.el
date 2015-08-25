;; travis-mode.el --- Mode for Travis

;; Copyright (C) 2014 Nicolas Lamirault <nicolas.lamirault@gmail.com>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

;;; Commentary:

;; A major mode for Travis

;;; Code:

;;; Code:

(require 'browse-url)
(require 'cl-lib)
(require 'tabulated-list)

;; Travis library

(require 'travis-builds)
(require 'travis-repos)
(require 'travis-ui)

(defconst travis-website "https://travis-ci.org/")

;; Actions

(defun travis--open-travis-project (id)
  "Go to the Travis web page."
  (let ((project (travis--get-repository id)))
    (if project
        ;;(browse-url
        (message
         (concat travis-website
                 (assoc-default 'slug (cdar project))))
      (message "Project not found: %s %s" id project))))

(defun travis-goto-project ()
  (interactive)
  (travis--open-travis-project (tabulated-list-get-id)))


;; Projects
;; ----------


(defvar travis--projects-mode-history nil)

(defun travis-show-projects (slug)
  "Show Travis projects using user request SLUG."
  (interactive
   (list (read-from-minibuffer "Projects: "
                               (car travis--projects-mode-history)
                               nil
                               nil
                               'travis--projects-mode-history)))
  (pop-to-buffer "*Travis projects*" nil)
  (travis-projects-mode)
  (setq tabulated-list-entries
        (travis--create-projects-entries (travis--get-repository slug)))
  (tabulated-list-print t))


(defun travis--create-project-entry (p)
  (list (format "%s" (cdr (assoc 'id p)))
        (vector ;id
         ;;(cdr (assoc 'last_build_state p))
         (colorize-build-state (cdr (assoc 'last_build_state p)))
         (cdr (assoc 'slug p))
         (let ((desc (cdr (assoc 'description p))))
           (if desc
               desc
             "")))))


(defun travis--create-projects-entries (projects)
  "Create entries for 'tabulated-list-entries from PROJECTS."
  (let ((data (cdar projects)))
    (if (eql 'vector (type-of data))
        (mapcar (lambda (p)
                  (travis--create-project-entry p))
                data)
      (list (travis--create-project-entry data)))))

;; Travis projects mode

(defvar travis-projects-mode-hook nil)

(defvar travis-projects-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "w") 'travis-goto-project)
    map)
  "Keymap for `travis-projects-mode' major mode.")

(define-derived-mode travis-projects-mode tabulated-list-mode
  "Travis projects"
  "Major mode for browsing Travis projects."
  :group 'travis
  (setq tabulated-list-format [;("ID" 5 t)
                               ("Status" 10 t)
                               ("Name"  25 t)
                               ("Description"  0 nil)
                               ])
  (setq tabulated-list-padding 2)
  (setq tabulated-list-sort-key (cons "Name" nil))
  (tabulated-list-init-header))


;; Project builds
;; ---------------

;; Builds

(defun travis--create-builds-entries (builds)
  "Create entries for 'tabulated-list-entries from BUILDS."
  (mapcar (lambda (b)
            ;(let ((id (number-to-string (cdr (assoc 'id b)))))
            (let ((id (format "%s" (cdr (assoc 'id b))))
                  (duration (cdr (assoc 'duration b)))
                  (finished (cdr (assoc 'finished_at b))))
              (list id
                    (vector id
                            (cdr (assoc 'number b))
                            (colorize-build-state (cdr (assoc 'state b)))
                            "Message"
                            "Commit"
                            "Committer"
                            (if (numberp duration)
                                (format-seconds "%m min %s sec" duration)
                              "")
                            (if (s-present? finished)
                                finished
                              "")))))
          (cl-cdadr builds)))

(defvar travis--project-builds-mode-history nil)

(defun travis-show-project-builds (slug)
  "Show Travis project builds using user request SLUG."
  (interactive
   (list (read-from-minibuffer "Project: "
                               (car travis--projects-mode-history)
                               nil
                               nil
                               'travis--projects-mode-history)))
  (pop-to-buffer "*Travis builds*" nil)
  (travis-project-builds-mode)
  (setq tabulated-list-entries
        (travis--create-builds-entries (travis--get-builds slug)))
  (tabulated-list-print t))


;; Travis project builds mode

(defvar travis-project-builds-mode-hook nil)

(defvar travis-project-builds-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "w") 'travis-goto-project)
    map)
  "Keymap for `travis-project-builds-mode' major mode.")

(define-derived-mode travis-project-builds-mode tabulated-list-mode
  "Travis project buids"
  "Major mode for browsing Travis project builds."
  :group 'travis
  (setq tabulated-list-format [;("ID" 5 t)
                               ("Build" 10 t)
                               ("Number" 7 t)
                               ("State" 10 t)
                               ("Message"  25 t)
                               ("Commit" 15 t)
                               ("Committer" 10 nil)
                               ("Duration" 15 nil)
                               ("Finished" 15 nil)])
  (setq tabulated-list-padding 2)
  (setq tabulated-list-sort-key (cons "Build" nil))
  (tabulated-list-init-header))


(provide 'travis-mode)
;;; travis-mode.el ends here
