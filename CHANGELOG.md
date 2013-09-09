## vNEXT

## v3.0.0
* Performance improvements
* Refactoring. As part of the refactoring, there is now only one option for timeout used for both open and read
and no more default values.

## v0.2.3
* Allow to set request headers via options hash
* Remove unnecessary code since 0.2.2 improved uri handling

## v0.2.2
* Improve uri handling

## v0.2.1
* Add license to `gemspec`

## v0.2.0
* Breaking change: ignore errors on `poke` only
* Allow chaining of `uri` and `path` methods to allow changing the target and chaining an HTTP request
* Add support for query string parameters

## v0.1.1
* Improve handling of url without scheme
* Add support for `https` requests
* Add `poke` (alias `ping`) method that returns true or false if 200 <= status < 400 of HEAD request

## v0.1.0
* Initial commit and push to Github
* Code refactoring

## v0.0.1

* Initial gem publishing
* Basic support for following HTTP verbs
    * HEAD
    * GET
    * POST
    * UPDATE
    * DELETE
    * OPTIONS


