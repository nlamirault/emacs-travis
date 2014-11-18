;;; travis-ui-test.el --- Tests for UI Travis settings

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


(defun extract-color-face (string)
  (cadr (text-properties-at 0 string)))


(defun test-travis-face (state face faces)
  (let ((f (extract-color-face (colorize-build-state state))))
    (should (eq face f))
    (should (find f faces))))

(ert-deftest test-travis-ui-colors-states ()
  (let ((faces (face-list)))
    (test-travis-face "canceled" 'travis--gray-face faces)
    (test-travis-face "created" 'travis--cyan-face faces)
    (test-travis-face "passed" 'travis--green-face faces)
    (test-travis-face "errored" 'travis--orange-face faces)
    (test-travis-face "failed" 'travis--red-face faces)))


(provide 'travis-ui-test)
;;; travis-ui-test.el ends here
