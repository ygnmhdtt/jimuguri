FROM ruby:2.5-alpine
LABEL maintainer ygnmhdtt <ygnmhdtt@gmail.com>

RUN apk update \
  && apk add --no-cache vim git curl wget \
  && alias vi="vim"

WORKDIR /app

ADD ./* ./

ENV RAILS_ENV=development
