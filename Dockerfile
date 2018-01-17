FROM ruby:2.5-alpine
LABEL maintainer ygnmhdtt <ygnmhdtt@gmail.com>

RUN apk update \
  && apk add --no-cache vim \
  && alias vi="vim"

WORKDIR /app

RUN gem install bundler && bundle init

ENV RAILS_ENV=development
