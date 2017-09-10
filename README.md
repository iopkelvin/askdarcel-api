# askdarcel-api [![Build Status](https://travis-ci.org/ShelterTechSF/askdarcel-api.svg?branch=master)](https://travis-ci.org/ShelterTechSF/askdarcel-api)

## macOS Set-up Instructions

### Install Dependencies

1. [Install Homebrew](http://brew.sh/).
2. Install [rbenv](https://github.com/rbenv/rbenv) and [ruby-build](https://github.com/rbenv/ruby-build#readme).
  - `brew install rbenv`
    + Follow further setup instructions (including updating your bash
      profile) from the link above.
    + Add the following lines to your `~/.bash_profile`
    ```
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    ```
  - `brew install ruby-build`
3. Install postgres.
  - `brew install postgresql`
    + Follow further setup instructions displayed after installation.
  - `brew services start postgres`


### Set up the project

After cloning the repository and `cd`ing into the workspace:

1. Install the required ruby version.
  - `rbenv install`
2. Install the required gems.
  - `bundle install`
  If encounter "command not found" error, run
  -`source ~/.bash_profile`
3. Install the `bundle` gem if it isn't yet installed.
    - `which bundle || gem install bundle`
4. Set up the development database and load dummy data.
  - `rake db:create:all`
  - `rake db:migrate`
  - `rake linksf:import`
5. Run the development server.
  - `rails s -b 0.0.0.0`
6. Do NOT do sudo install -rails


## Docker-based Development Set-up Instructions

### Requirements

Docker Engine >= 1.10
Docker Compose >= 1.6

Follow the [Docker installation instructions](https://www.docker.com/products/overview) for your OS.

### Set up the project

This is not a full guide to Docker and Docker Compose, so please consult other
guides to learn more about those tools.

```sh
# Start the database container (in the background with -d)
$ docker-compose up -d db

# Populate the initial development database
$ docker-compose run --rm api rake db:create db:schema:load linksf:import

# Start the Rails development server in the api container (in the foreground)
$ docker-compose up api

# To stop all containers, including background ones
$ docker-compose stop
```

### Running Postman tests from the command line

```sh
# Refresh DB
$ docker-compose run --rm api rake db:create db:schema:load linksf:import

# Run Docker container that executes Postman CLI tool named newman
$ docker-compose run --rm postman
```
