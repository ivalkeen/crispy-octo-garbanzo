crispy-octo-garbanzo
====================

Technologies
------------

Following frameworks/libraries are being used in the project:

* [Cuba](https://github.com/soveran/cuba) as a fast and lightweight web framework
* [ERB](http://ruby-doc.org/stdlib-2.2.3/libdoc/erb/rdoc/ERB.html) as a template engines as the most standard Ruby solution
* [Net::HTTP](http://docs.ruby-lang.org/en/2.2.0/Net/HTTP.html) for HTTP communication, as it is standard and also supports GZip encryption out of the box
* [Twitter bootstrap](http://getbootstrap.com/) (loaded from CDN) for simple layout and basic look and feel

`FyberGateway` is a Facade for the communication with Fyber API for the application.
Hash calculation, response signature validation, offers api request and response are implemented as separate classes.
Individual offer is currently represented by just a Hash inside `OffersResponse` object, but more proper implementation could be creating an object representation for it,
however I've decided that it's out of scope of this project.

All the classes are documented with [YARD](https://github.com/lsegal/yard)

Testing
-------

* [Minitest](https://github.com/seattlerb/minitest) for unit and acceptance testing
* [Capybara](https://github.com/jnicklas/capybara) for acceptance testing of the web application
* [Webmock](https://github.com/bblimke/webmock) to mock API calls in tests with some pre-recorded responses

All of the classes are covered with unit tests.
There is also an acceptance test, which simulates user input and verifies output.

Configuration
-------------

Configuration is stored in environment variables on production and loaded from `.env` files in development/test
(using [Dotenv](https://github.com/bkeepers/dotenv) gem).

Security
--------

* Token based CSRF protection is implemented to allow only requests from the application
* XSS protection is implemented by escaping all the output

Hosting
-------

Heroku was chosen for deployment as the simplest (and free) option
