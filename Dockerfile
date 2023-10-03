FROM ruby:3.1.2

WORKDIR /rack_app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 9292

CMD ["bundle", "exec", "puma"]
