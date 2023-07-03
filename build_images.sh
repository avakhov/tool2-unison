#!/bin/bash
export BUILD_VERSION="v1"
export DEV_BASE_VERSION="v2"
set -ex

cat Dockerfile-unison | docker build -t tool2/unison:$BUILD_VERSION -
docker push tool2/unison:$BUILD_VERSION

cat Dockerfile-dev-base | docker build -t tool2/dev-base:$DEV_BASE_VERSION -
docker push tool2/dev-base:$DEV_BASE_VERSION

(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.6.6' -t tool2/dev-ruby:2.6.6-$BUILD_VERSION -
docker push tool2/dev-ruby:2.6.6-$BUILD_VERSION

(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.7.4' -t tool2/dev-ruby:2.7.4-$BUILD_VERSION -
docker push tool2/dev-ruby:2.7.4-$BUILD_VERSION

(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.7.5' -t tool2/dev-ruby:2.7.5-$BUILD_VERSION -
docker push tool2/dev-ruby:2.7.5-$BUILD_VERSION

(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=3.2.2' -t tool2/dev-ruby:3.2.2-$BUILD_VERSION -
docker push tool2/dev-ruby:3.2.2-$BUILD_VERSION
