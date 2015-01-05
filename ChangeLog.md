# emacs-travis ChangeLog

# Version 0.5.0 (IN PROGRESS)

- Update unit tests configuration for [overseer][]
- ``FIX`` unit tests for travis builds

# Version 0.4.0 (12/22/2014)

- Update unit tests
- ``FIX`` TravisCI setup

# Version 0.3.0 (11/21/2014)

- Add Vagrant configuration for testing in a virtual machine
- ``FIX`` remove ansi library to dependencies
- ``FIX`` if duration input is empty, display 0.
- Test TravisUI faces

# Version 0.2.0 (11/16/2014)

- Add [TravisCI][] and [Drone.io][] for continuous integration
- Implements Travis mode to display projects build status
- Enable code coverage

# Version 0.1.0 (11/14/2014)

- Retrieve builds
- Retrieve users
- Retrieve projects
- API authentication
- Init project


[TravisCI]: https://travis-ci.org/nlamirault/emacs-travis
[Drone.io]: https://drone.io/github.com/nlamirault/emacs-travis
[overseer]: https://github.com/tonini/overseer.el
