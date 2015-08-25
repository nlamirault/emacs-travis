;;; travis-mode-test.el --- Tests for Travis mode

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

;; (require 'travis-mode)


(ert-deftest test-travis-mode-projects-keybindings ()
  (with-test-sandbox
   (travis-projects-mode)
   (should (eql 'travis-goto-project
                (key-binding (kbd "w"))))))

(ert-deftest test-travis-mode-show-projects ()
  (with-test-sandbox
   (travis-show-projects "nlamirault")
   (with-current-buffer "*Travis projects*"
     (let ((content (buffer-string)))
       (should (s-contains? "nlamirault/emacs-gitlab"
                            content))
       (should (s-contains? "nlamirault/emacs-travis"
                            content))))))

;; (ert-deftest test-travis-mode-builds-keybindings ()
;;   (with-test-sandbox
;;    (travis-project-builds-mode)
;;    (should (eql 'travis-goto-project
;;                 (key-binding (kbd "w"))))))

(ert-deftest test-travis-mode-show-project-builds ()
  (with-test-sandbox
   (travis-show-project-builds "nlamirault/emacs-travis")
   (with-current-buffer "*Travis builds*"
     (let ((content (buffer-string)))
       (should (s-contains? "Committer"
                            content))))))


(provide 'travis-mode-test)
;;; travis-mode-test.el ends here
