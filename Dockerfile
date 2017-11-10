FROM ruby:2.4-alpine
MAINTAINER "Erwan Guyader <taratatach@mozfr.org>"

ARG version=0.51.0

RUN gem install rubocop -v ${version}

WORKDIR /app
VOLUME /app

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

