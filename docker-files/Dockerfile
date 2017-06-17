FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /bugs_app
ADD . /bugs_app/
WORKDIR /bugs_app
RUN bundle install
