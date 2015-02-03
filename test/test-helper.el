;; test-helper.el --- Test helpers for travis.el

;; Copyright (C) 2014, 2015 Nicolas Lamirault <nicolas.lamirault@gmail.com>

;; Author: Nicolas Lamirault <nicolas.lamirault@gmail.com>
;; Homepage: https://github.com/nlamirault/emacs-travis

;;; License:

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'ansi)
(require 'cl) ;; http://emacs.stackexchange.com/questions/2864/symbols-function-definition-is-void-cl-macroexpand-all-when-trying-to-instal
(require 'ert)
(require 'f)
(require 'undercover)

(setq debugger-batch-max-lines (+ 50 max-lisp-eval-depth)
      debug-on-error t)

(defvar username (getenv "HOME"))

(defconst travis-testsuite-dir
  (f-parent (f-this-file))
  "The testsuite directory.")

(defconst travis-source-dir
  (f-parent travis-testsuite-dir)
  "The travis.el source directory.")

(defconst travis-sandbox-path
  (f-expand "sandbox" travis-testsuite-dir)
  "The sandbox path for travis.")

(defun cleanup-load-path ()
  "Remove home directory from 'load-path."
  (message (ansi-green "[travis] Cleanup path"))
  (mapc #'(lambda (path)
            (when (string-match (s-concat username "/.emacs.d") path)
              (message (ansi-yellow "Suppression path %s" path))
              (setq load-path (delete path load-path))))
        load-path)
  (add-to-list 'load-path default-directory))

(defun load-unit-tests (path)
  "Load all unit test from PATH."
  (message (ansi-green "[travis] Execute unit tests %s"
                       path))
  (dolist (test-file (or argv (directory-files path t "-test.el$")))
    (load test-file nil t)))


(defun load-library (file)
  "Load current library from FILE."
  (let ((path (s-concat travis-source-dir file)))
    (message (ansi-yellow "[travis] Load library from %s" path))
    (undercover "*.el" (:exclude "*-test.el"))
    (require 'travis path)))


(defun setup-travis ()
  "Setup Travis token from TRAVIS_TOKEN environment variable."
  (setq travis-token-id (getenv "TRAVIS_TOKEN")))


(defmacro with-test-sandbox (&rest body)
  "Evaluate BODY in an empty sandbox directory."
  `(unwind-protect
       (condition-case nil ;ex
           (let (;;(user-emacs-directory travis-sandbox-path)
                 (default-directory travis-source-dir))
             ;; (unless (f-dir? travis-sandbox-path)
             ;;   (f-mkdir travis-sandbox-path))
             (cleanup-load-path)
             (load-library "/travis.el")
             (setup-travis)
             ,@body)
         ;; (f-delete overseer-sandbox-path :force)))
         )))
         ;; (error
         ;;  (message (ansi-red "[Scame] Error during unit tests : %s" ex))))))


(provide 'test-helper)
;;; test-helper.el ends here
