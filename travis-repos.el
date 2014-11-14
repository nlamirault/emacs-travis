;;; travis-repos.el --- Travis REPOS settings.

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

(require 'travis-utils)

(defun travis--get-repositories ()
  "Retrieve repository from his REPO-ID."
  (travis--perform-http-request "GET"
                                "repos"
                                nil
                                200))


(defun travis--get-repository (repo-id)
  "Retrieve repository from his REPO-ID."
  (travis--perform-http-request "GET"
                                (s-concat "repos/" repo-id)
                                nil
                                200))


(provide 'travis-repos)
;;; travis-repos.el ends here
