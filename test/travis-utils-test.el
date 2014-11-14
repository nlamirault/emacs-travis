;;; travis-utils-test.el --- Tests for Travis tools

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


(ert-deftest test-travis-api-headers-without-authentication ()
  (let ((headers (travis--get-headers))
        (token (getenv "TRAVIS_TOKEN")))
    (should (string-equal "emacs-travis/0.1.0"
                          (assoc-default "User-Agent" headers)))
    (should (string-equal "application/vnd.travis-ci.2+json"
                          (assoc-default "Accept" headers)))
    (should (eql nil (assoc-default "Authorization" headers)))))


(provide 'travis-utils-test)
;;; travis-utils-test.el ends here
