#!/bin/bash
set -ex

export UNISON_VERSION="v1"
cat Dockerfile-unison | docker build -t tool2/unison:$UNISON_VERSION -
docker push tool2/unison:$UNISON_VERSION

export DEV_BASE_VERSION="v2"
cat Dockerfile-dev-base | docker build -t tool2/dev-base:$DEV_BASE_VERSION -
docker push tool2/dev-base:$DEV_BASE_VERSION

export BUILD_VERSION_251="v1"
(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.5.1' -t tool2/dev-ruby:2.5.1-$BUILD_VERSION_251 -
docker push tool2/dev-ruby:2.5.1-$BUILD_VERSION_251

export BUILD_VERSION_266="v1"
(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.6.6' -t tool2/dev-ruby:2.6.6-$BUILD_VERSION_266 -
docker push tool2/dev-ruby:2.6.6-$BUILD_VERSION_266

export BUILD_VERSION_274="v1"
(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.7.4' -t tool2/dev-ruby:2.7.4-$BUILD_VERSION_274 -
docker push tool2/dev-ruby:2.7.4-$BUILD_VERSION_274

export BUILD_VERSION_275="v1"
(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.7.5' -t tool2/dev-ruby:2.7.5-$BUILD_VERSION_275 -
docker push tool2/dev-ruby:2.7.5-$BUILD_VERSION_275

export BUILD_VERSION_302="v1"
(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=3.0.2' -t tool2/dev-ruby:3.0.2-$BUILD_VERSION_302 -
docker push tool2/dev-ruby:3.0.2-$BUILD_VERSION_302

export BUILD_VERSION_322="v1"
(cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=3.2.2' -t tool2/dev-ruby:3.2.2-$BUILD_VERSION_322 -
docker push tool2/dev-ruby:3.2.2-$BUILD_VERSION_322

echo done.
