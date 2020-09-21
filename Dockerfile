FROM lsiobase/ubuntu:focal

# set version label
ARG BUILD_DATE
ARG VERSION
#LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="IronicBadger"

# packages as variables
ARG RUNTIME_PACKAGES="\
	build-essential \
    git \
    ruby-full \
    zlib1g-dev"

ENV PATH="/usr/local/ruby/bin:${PATH}"
ENV RAILS_ENV="production"

RUN \
  echo "**** install jekyll deps ****" && \
  apt-get update && \
  apt-get install -y \
      $RUNTIME_PACKAGES && \
  echo "**** install jekyll ****" && \ 
  gem install jekyll bundler && \
  echo "**** install chowdown ****" && \
  git clone https://github.com/clarklab/chowdown.git /app/chowdown && \
  cd /app/chowdown

COPY root/ /

WORKDIR /app/chowdown
EXPOSE 3000
VOLUME /config