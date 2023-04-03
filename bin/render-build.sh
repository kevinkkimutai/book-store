#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install


# migrate
bundle exec rake db:migrate db:seed