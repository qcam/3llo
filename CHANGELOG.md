# CHANGELOG

## v1.3.1

* Require Ruby version 3

## v1.3.0 (yanked)

* Support Ruby version 3
* Fix comment listing (#86)

## v1.2.0

* Support running multiple commands with `--init` switch (#83)
* Include current board name to status line (#77)
* Introduce `card add-label` command (#74)
* Support multiline card description (#72)

## v1.1.0

* Introduce "list add" command.
* Introduce "board add" command.
* Introduce label related command.
* Support exiting with Ctrl+D.

## v1.0.0

* Support using shortcuts to access entities.
* Introduce `--config` switch.
* Introduce `--init` switch.
* Introduce `--configure` switch.
* Deprecate using environment variables for configuration.
* Improve performance of several commands.
* Support checklist related commands.
* Support Ruby 2.5+.
* Introduce `card edit` command.
* Improve command auto completion.

## v0.3.1

* Improve self-documentation [#39](https://github.com/qcam/3llo/pull/39).

## v0.3.0

* Accept multiline in "card comment" command [#33](https://github.com/qcam/3llo/pull/33).
* Upgrade `tty-prompt` dependency to 0.12.0.
* Support Ruby 2.0+.
