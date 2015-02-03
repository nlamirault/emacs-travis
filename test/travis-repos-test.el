;;; travis-repos-test.el --- Tests for Travis repositories

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

;; (require 'travis-repos)


(ert-deftest test-travis-get-repositories ()
  (with-test-sandbox
   (travis--get-auth)
   (let ((response (travis--get-repositories)))
     ;;(message "Response: %s" response)
     (should (vectorp (cdar response)))
     (mapc (lambda (r)
             ;;(message "repo: %s" r)
             (should (not (s-blank? (cdr (assoc 'slug r)))))
             (should (numberp (cdr (assoc 'id r)))))
           (cdar response)))))

(ert-deftest test-travis-get-my-repositories ()
  (with-test-sandbox
   (travis--get-auth)
   (let ((response (travis--get-repository "nlamirault")))
     (mapc (lambda (r)
             ;; (message "repo: %s" r)
             (should (s-contains? "nlamirault/"
                                  (cdr (assoc 'slug r)))))
           (cdar response)))))

(ert-deftest test-travis-get-single-repository ()
  (with-test-sandbox
   (travis--get-auth)
   (let ((response (travis--get-repository "nlamirault/scame")))
     ;; (message "Repo : %s" response)
     (should (not (vectorp (cdar response))))
     (should (string-equal "Emacs Lisp"
                           (cdr (assoc 'github_language (cdar response)))))
     (should (numberp (cdr (assoc 'last_build_id (cdar response)))))
     (should (s-numeric? (cdr (assoc 'last_build_number (cdar response)))))
     (should (string-equal "nlamirault/scame"
                           (cdr (assoc 'slug (cdar response))))))))

(provide 'travis-repos-test)
;;; travis-repos-test.el ends here
