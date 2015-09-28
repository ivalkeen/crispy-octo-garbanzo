Offers api
==========

Technical decisions
-------------------

* [Cuba](https://github.com/soveran/cuba) web framework
* `erb` as a template engine
* Twitter bootstrap (loaded from CDN) for simple layout and basic look and feel
* Minitest for testing (Capybara for acceptance test)
* Webmock to mock API calls in tests with some pre-recorded responses
* Configuration is stored in environment variables on production and loaded from `.env` files in development/test
(using `dotenv` gem). There is an interface to the configuration through the `Config` class to hide this detail
from the rest of the system

TODO
----

* Document code using YARD
* Update README to describe all decisions
* Push code to github
* Deploy app to heroku
