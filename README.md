# Southwest Checkin 2.0

[![Build Status](https://travis-ci.org/aortbals/southwest-checkin.svg?branch=master)](https://travis-ci.org/aortbals/southwest-checkin) [![Coverage Status](https://coveralls.io/repos/aortbals/southwest-checkin/badge.svg?branch=master&service=github)](https://coveralls.io/github/aortbals/southwest-checkin?branch=master)

Automatically checks in passengers for their Southwest Flight.

Version 2.0 of this project is a complete rewrite of the service. The brittle HTML parsing and form submissions are a thing of the past. A much better approach is being taken to automate checkins. And, importantly, the new version has a robust test suite. It is even written in a new language (Ruby) and framework (Rails).

If you are interested in the old version, see the [1.0 branch](https://github.com/aortbals/southwest-checkin/tree/1.0).

## Features

- Accounts
    - an easy and convient way to manage your reservations
    - view or remove your reservations at any time
    - increased security
- Email Notifications
    - Notified when a reservation is added
    - Notified on successful checkin
- Checks in all passengers for a given confirmation number
- Secured via HTTPS
- Modern UI
- Modern background processing and job scheduling
- Full test suite


## Local Installation

1. Move .env.example to .env and edit as needed

2. Databse

    Note: 'secure_password_here' should match SOUTHWEST_CHECKIN_DATABASE_PASSWORD from .env

    ```shell
    db=$(docker run -itd postgres)
    docker exec -it $db psql -Upostgres -c "CREATE ROLE southwest_checkin WITH LOGIN CREATEDB PASSWORD 'secure_password_here';"
    ```

3. APP

    - build
    ```shell
    docker build -t $(whoami)/southwest -f Dockerfile-dev .
    ```
    - run
    ```shell
    app=$(docker run -itd --name southwest --link $db:postgres -p 3000:3000/tcp $(whoami)/southwest)
    ```

4. Create and seed the database:

    ```shell
    docker exec -it $app bash -c 'rake db:create db:migrate db:seed && rake db:migrate db:seed RAILS_ENV=test'
    ```

5. Adding some basic test data for development:

    ```shell
    docker exec -it $app bash -c 'rake dev:prime'
    ```

6. Run the tests:

    ```shell
    docker exec -it $app bash -c 'rspec'
    ```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Write rspec tests
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
