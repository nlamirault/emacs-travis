;;; travis-auth-test.el --- Tests for Travis tools

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

;; (require 'travis-utils)


(ert-deftest test-travis-headers-after-authentication ()
  (with-test-sandbox
   (travis--get-auth)
   (let ((headers (travis--get-headers)))
     ;; (message "Headers: %s" headers)
     (should (s-contains? "token"
                          (assoc-default "Authorization" headers))))))


(ert-deftest test-travis-get-hello-world ()
  (with-test-sandbox
   (travis--get-auth)
   (let ((response (travis--perform-http-request "GET" "" nil 200)))
     ;;(message "Response: %s" response)
     (should (string-equal "hello" (caar response)))
     (should (string-equal "world" (cdar response))))))


(provide 'travis-auth-test)
;;; travis-auth-test.el ends here
