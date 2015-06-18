FROM ruby:2.2
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
ENV HTTP_PROXY="192.168.1.6:7777"
RUN bundle install
CMD ["/usr/local/bundle/bin/foreman","start","--root","/usr/src/app"]
