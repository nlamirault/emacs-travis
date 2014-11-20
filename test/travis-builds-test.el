;;; travis-builds-test.el --- Tests for Travis builds

;; Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

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


(require 'travis-builds)


(ert-deftest test-travis-get-builds-for-repo ()
  (travis--get-auth)
  (let ((response (travis--get-builds "nlamirault/scame")))
    ;;(message "Builds : %s" response)
    (should (vectorp (cdar response)))
    (mapc (lambda (b)
             ;; (message "Build : %s" b)
             (should (not (s-blank? (cdr (assoc 'message b)))))
             (should (not (s-blank? (cdr (assoc 'author_email b)))))
             (should (not (s-blank? (cdr (assoc 'author_name b)))))
             (should (numberp (cdr (assoc 'id b)))))
          (cdar response))))

(provide 'travis-builds-test)
;;; travis-builds-test.el ends here
