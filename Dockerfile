FROM ruby:2.1.5
MAINTAINER Soloman Weng "solomanw@everydayhero.com.au"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
RUN bundle install

ADD . /usr/src/app

CMD ["/bin/bash"]
