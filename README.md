Offers api
==========

Technical decisions
-------------------

* [Cuba](https://github.com/soveran/cuba) web framework
* token-based CSRF protection (which is provided by `Cuba` out of the box)
* `erb` as a template engine
* Twitter bootstrap (loaded from CDN) for simple layout and basic look and feel
* Minitest for testing (Capybara for acceptance test)
* Webmock to mock API calls in tests

TODO
----

* Implement XSS protection when rendering results and errors
* Document code using YARD
* Update README to describe all decisions
* Push code to github
* Deploy app to heroku
