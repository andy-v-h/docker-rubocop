ARG RUBY_VERSION=2.6.3-alpine

FROM ruby:${RUBY_VERSION} AS build
RUN apk add --update \
  build-base \
  ruby-dev

ARG VERSION=0.60.0
RUN gem install rubocop -v ${VERSION}
RUN rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

FROM ruby:${RUBY_VERSION}

LABEL io.whalebrew.name 'rubocop'
LABEL io.whalebrew.config.working_dir '/workdir'
WORKDIR /workdir

COPY --from=build /usr/local/bundle /usr/local/bundle

ENTRYPOINT ["rubocop"]
CMD ["--help"]
