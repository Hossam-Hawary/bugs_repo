FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /bugs_app
WORKDIR /bugs_app
ADD Gemfile /bugs_app/Gemfile
ADD Gemfile.lock /bugs_app/Gemfile.lock
RUN bundle install
ADD . /myapp

