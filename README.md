# emacs-travis

[![License GPL 2][badge-license]][LICENSE]
[![Coverage Status](https://coveralls.io/repos/nlamirault/emacs-travis/badge.png)](https://coveralls.io/r/nlamirault/emacs-travis)

Master :
* [![MELPA Stable](http://stable.melpa.org/packages/travis-badge.svg)](http://stable.melpa.org/#/travis)
* [![Circle CI](https://circleci.com/gh/nlamirault/emacs-travis/tree/master.svg?style=svg)](https://circleci.com/gh/nlamirault/emacs-travis/tree/master)

Develop:
* [![Melpa Status](http://melpa.milkbox.net/packages/travis-badge.svg)](http://melpa.milkbox.net/#/travis)
* [![Circle CI](https://circleci.com/gh/nlamirault/emacs-travis/tree/develop.svg?style=svg)](https://circleci.com/gh/nlamirault/emacs-travis/tree/develop)

`travis` provides a REST client to the [Travis][] API

## Installation

### Installation via package.el

`package.el` is the built-in package manager in Emacs.

emacs-travis is available on the two major community maintained repositories -
[MELPA STABLE](melpa-stable.milkbox.net), [MELPA](http://melpa.milkbox.net).

You can install `travis` with the following commnad:

<kbd>M-x package-install [RET] travis [RET]</kbd>

or by adding this bit of Emacs Lisp code to your Emacs initialization file
(`.emacs` or `init.el`):

```el
(unless (package-installed-p 'travis)
  (package-install 'travis))
```

If the installation doesn't work try refreshing the package list:

<kbd>M-x package-refresh-contents [RET]</kbd>

Keep in mind that MELPA packages are built automatically from
the `master` branch, meaning bugs might creep in there from time to
time. Never-the-less, installing from MELPA is the recommended way of
obtaining emacs-travis, as the `master` branch is normally quite stable and
"stable" (tagged) builds are released somewhat infrequently.

With the most recent builds of Emacs, you can pin emacs-travis to always
use MELPA Stable by adding this to your Emacs initialization:

```el
(add-to-list 'package-pinned-packages '(travis . "melpa-stable") t)
```

### Via el-get

[el-get](https://github.com/dimitri/el-get) is another popular package manager for Emacs. If you're an el-get
user just do <kbd>M-x el-get-install [RET] travis [RET]</kbd>.

### Manual

You can install emacs-travis manually by placing it on your `load-path` and
`require` ing it. Many people favour the folder `~/.emacs.d/vendor`.

```el
(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'travis)
```

## Usage

* Setup your Travis configurations using your Github token :

        $ export TRAVIS_TOKEN=xxxxxx

* Display your Travis build status for some projects:

        M-x travis-show-projects

See ![TravisCI](images/emacs-travis.png)


## Development

### Cask

``emacs-travis`` use [Cask][] for dependencies
management. Install it and retrieve dependencies :

    $ curl -fsSkL https://raw.github.com/cask/cask/master/go | python
    $ export PATH="$HOME/.cask/bin:$PATH"
    $ cask


### Tests

* Launch unit tests :

        $ export TRAVIS_TOKEN xxxxxx
        $ make clean test


## Support / Contribute

See [here](CONTRIBUTING.md)



## Changelog

A changelog is available [here](ChangeLog.md).


## License

See [LICENSE](LICENSE).


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>


[emacs-travis]: https://github.com/nlamirault/emacs-travis
[badge-license]: https://img.shields.io/badge/license-GPL_2-green.svg?style=flat
[LICENSE]: https://github.com/nlamirault/emacs-travis/blob/master/LICENSE

[GNU Emacs]: https://www.gnu.org/software/emacs/
[MELPA]: http://melpa.milkbox.net/
[Cask]: http://cask.github.io/
[Issue tracker]: https://github.com/nlamirault/emacs-travis/issues
[Helm]: https://github.com/emacs-helm/helm
