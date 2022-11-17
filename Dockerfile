FROM ruby:2.1.2

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010 &&\
  apt-get update -qq &&\
  apt-get install -y --force-yes nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY bower.json ./
RUN npm install -g bower 
RUN bower install

COPY . .

EXPOSE 4567

cmd ["middleman"]
