FROM ruby:2.4.2

RUN mkdir /app
WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

CMD ./bin/sidekiq scheduler
