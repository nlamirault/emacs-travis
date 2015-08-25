;;; travis-utils.el --- some tools

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

(require 'json)
(require 'request)
(require 's)


(require 'travis-api)
(require 'travis-version)


;; Errors

(eval-and-compile
  (unless (fboundp 'define-error)
    ;; Shamelessly copied from Emacs trunk :)
    (defun define-error (name message &optional parent)
      "Define NAME as a new error signal.
MESSAGE is a string that will be output to the echo area if such an error
is signaled without being caught by a `condition-case'.
PARENT is either a signal or a list of signals from which it inherits.
Defaults to `error'."
      (unless parent (setq parent 'error))
      (let ((conditions
             (if (consp parent)
                 (apply #'nconc
                        (mapcar (lambda (parent)
                                  (cons parent
                                        (or (get parent 'error-conditions)
                                            (error "Unknown signal `%s'" parent))))
                                parent))
               (cons parent (get parent 'error-conditions)))))
        (put name 'error-conditions
             (delete-dups (copy-sequence (cons name conditions))))
        (when message (put name 'error-message message))))))

(define-error 'travis-error "Travis error")

(define-error 'travis-http-error "HTTP Error" 'travis-error)


;; HTTP tools

(defun travis--get-rest-uri (uri)
  "Retrieve the Travis API complete url using the API version.
`URI` is the api path."
  (if travis--host
      (s-concat travis--host "/" uri)
    (error (signal 'travis-error '("Travis host unknown.")))))


(defun travis--get-github-token ()
  "Retrieve the Travis token ID."
  (getenv "TRAVIS_TOKEN"))


(defun travis--get-headers ()
  "Generate HTTP headers for Travis API."
  (let ((headers (list (cons "User-Agent"
                             (s-concat travis--user-agent
                                       "/"
                                       (travis--library-version)))
                       (cons "Accept"
                             "application/vnd.travis-ci.2+json"))))
    (if travis--token-id
      (-snoc headers
             (cons "Authorization"
                   (s-concat "token " travis--token-id)))
      headers)))


(defun travis--perform-http-request (method uri params status-code)
  "Do a HTTP METHOD request using URI and PARAMS.
If HTTP return code is STATUS-CODE, send the response content otherwise
raise an error."
  (let ((response (request (travis--get-rest-uri uri)
                           :type method
                           :headers (travis--get-headers)
                           :sync t
                           :data params
                           :parser 'json-read)))
    (if (= status-code (request-response-status-code response))
        (request-response-data response)
      (error
       (signal 'travis-http-error
               (list (request-response-status-code response)
                     (request-response-data response)))))))


(provide 'travis-utils)
;;; travis-utils.el ends here
