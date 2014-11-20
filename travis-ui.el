;;; travis-ui.el --- Travis UI tools

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

;;; Code:

;;(require 'ansi)
(require 'tabulated-list)


;;
;; to display faces in IELM :
;; ELISP (list-faces-display "travis")
;;

;; Faces

(defface travis--title
  '((((class color) (background light)) :foreground "red" :weight semi-bold)
    (((class color) (background dark)) :foreground "green" :weight semi-bold))
  "face of Travis information"
  :group 'travis)

(defface travis--gray-face
  '((((class color)) :foreground "#b1b6b6"))
  "Gray color.."
  :group 'travis)

(defface travis--cyan-face
  '((((class color)) :foreground "#00ffff"))
  "Cyan color.."
  :group 'travis)

(defface travis--yellow-face
  '((((class color)) :foreground "#e5e500"))
  "Yellow color."
  :group 'travis)

(defface travis--orange-face
  '((((class color)) :foreground "#ff5500"))
  "Orange color.."
  :group 'travis)

(defface travis--red-face
  '((((class color)) :foreground "#cd4d40"))
  "Red color.."
  :group 'travis)

(defface travis--green-face
  '((((class color)) :foreground "#61b361"))
  "Green color."
  :group 'travis)



(defun colorize-build-state (state)
  "Colorize face using STATE."
  (cond
   ((string= state "canceled")
    (propertize state 'face 'travis--gray-face))
   ((string= state "failed")
    (propertize state 'face 'travis--red-face))
   ((string= state "errored")
    (propertize state 'face 'travis--orange-face))
   ((string= state "passed")
    (propertize state 'face 'travis--green-face))
   ((string= state "created")
    (propertize state 'face 'travis--cyan-face))
   (t (propertize state 'face 'travis--gray-face))))


;; (defun colorize-dot (color)
;;   (cond
;;    ((string= color  "red")
;;     (propertize "●" 'face 'travis--red-face))
;;    ((string= color "yellow")
;;     (propertize "●" 'face 'travis--yellow-face))
;;    ((string= color  "green")
;;     (propertize "●" 'face 'travis--green-face))
;;    (t (concat "Unknown: " "'" color "' "))))

(provide 'travis-ui)
;;; travis-ui.el ends here
