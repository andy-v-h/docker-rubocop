ARG RUBY_VERSION=2.5.3-alpine

FROM ruby:${RUBY_VERSION} AS build
RUN apk add --update \
  build-base \
  ruby-dev

ARG VERSION=0.60.0
RUN gem install rubocop -v ${VERSION}

FROM ruby:${RUBY_VERSION}
COPY --from=build /usr/local/bundle/ /usr/local/bundle/

WORKDIR /app
VOLUME /app

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

