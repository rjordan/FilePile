FROM stackbrew/ubuntu:saucy
MAINTAINER Richard Kent Jordan <rjordan@pobox.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libpq5 libpq-dev libcurl4-gnutls-dev python-software-properties libffi-dev libgdbm-dev nodejs ruby2.0 ruby2.0-dev
RUN gem update --system
RUN gem install bundler

ADD . /app            
         
ENV RAILS_ENV production
WORKDIR /app
RUN bundle install --without development test
RUN rake tmp:create
RUN rake assets:precompile

#Rails (Must set production.rb to serve static assets)
EXPOSE 3000
CMD foreman start

