# Use the Ruby 2.7.1 image from Docker Hub
# as the base image (https://hub.docker.com/_/ruby)
FROM ruby:2.6.6

ENV DATABASE_HOST=db/development.sqlite3

ENTRYPOINT ["./docker-entrypoint.sh"]

# Install Yarn.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Run yarn install to install JavaScript dependencies.
RUN yarn install --check-files

# Use a directory called /code in which to store
# this application's files. (The directory name
# is arbitrary and could have been anything.)
WORKDIR /code

# Copy all the application's files into the /code
# directory.
COPY . /code

# Run bundle install to install the Ruby dependencies.
RUN gem install bundler -v '2.2.14'
RUN bundle install

EXPOSE 3000

# Set "rails server -b 0.0.0.0" as the command to
# run when this container starts.
CMD ["bin/rails", "server", "-b", "0.0.0.0"]