FROM ruby:2.6.5-stretch

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN gem install bundler --version 2.1.4

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN mkdir /app
RUN npm install -g yarn

WORKDIR /app

COPY Gemfile.lock Gemfile package.json yarn.lock ./

RUN bundle install
RUN yarn install --no-lockfile

ADD . /app

EXPOSE 3000:3000
CMD ["rails", "server", "-b", "0.0.0.0"]

