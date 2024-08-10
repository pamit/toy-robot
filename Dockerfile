# Using multi-stage builds to optimise Docker images
FROM ruby:3.1.3 AS stage1

LABEL maintainer="pamit.edu@gmail.com"
LABEL description="This image includes a Ruby command-line app \
to simulate a toy robot moving on a table with commands."

RUN echo "Installing dependenies..."
RUN apt-get update -qq \
  && apt-get -y --no-install-recommends install build-essential

RUN useradd -ms /bin/bash toy-robot-user
USER toy-robot-user

ENV INSTALL_PATH /home/toy-robot-user/app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# Improving caching
COPY Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle install --jobs `getconf _NPROCESSORS_ONLN` --retry 3 --quiet \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

# Final stage
FROM ruby:3.1.3

ENV INSTALL_PATH /home/toy-robot-user/app
WORKDIR $INSTALL_PATH

COPY --from=stage1 $INSTALL_PATH $INSTALL_PATH
COPY . ./

RUN chmod +x $INSTALL_PATH/docker-entrypoint.sh
ENTRYPOINT ["/home/toy-robot-user/app/docker-entrypoint.sh"]

ENV MAP_MAX_X=5
ENV MAP_MAX_Y=5

CMD rake robot:run[${MAP_MAX_X},${MAP_MAX_Y}]
