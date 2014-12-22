;;; travis-version-test.el --- Tests for version information

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

(require 'pkg-info)

(setq current-version "0.5.0")


(ert-deftest travis-library-version ()
  (should (string= current-version (travis--library-version))))

(ert-deftest emacs-travis-version ()
  (should (string= current-version (emacs-travis-version))))


(provide 'travis-version-test)
;;; travis-version-test.el ends here
