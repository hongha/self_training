FROM ruby:2.7.0-alpine3.11

ENV BUNDLE_PATH=/bundle \
    GEM_PATH=/bundle

RUN apk add --update --no-cache \
      bash build-base postgresql-dev tzdata git \
      graphviz ttf-freefont  file imagemagick && \
      gem install bundler

# create application directory
RUN mkdir /app

# Set our working directory inside the image
WORKDIR /app

# Setting env up
ENV RAILS_ENV='development'
ENV RACK_ENV='development'

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

EXPOSE 3000

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]