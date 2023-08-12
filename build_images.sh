#!/bin/bash

if [ "$1" == "all" ]; then
export DOCKER_BUILDX='docker buildx build --platform linux/amd64,linux/arm64 --push'
else if [ "$1" == "amd" ]; then
export DOCKER_BUILDX='docker buildx build --platform linux/amd64 --push'
else if [ "$1" == "m" ]; then
export DOCKER_BUILDX='docker buildx build --platform linux/arm64 --push'
else
echo "expect arg: all,amd,m"
exit -1
fi

export UNISON_VERSION="v2"
export DEV_BASE_VERSION="v3"
export RUBY_BUILD_VERSION_251="v2"
export RUBY_BUILD_VERSION_266="v2"
export RUBY_BUILD_VERSION_274="v2"
export RUBY_BUILD_VERSION_275="v2"
export RUBY_BUILD_VERSION_302="v2"
export RUBY_BUILD_VERSION_322="v2"

set -ex
# cat Dockerfile-unison | $DOCKER_BUILDX -t tool2/unison:$UNISON_VERSION -

# cat Dockerfile-dev-base | $DOCKER_BUILDX -t tool2/dev-base:$DEV_BASE_VERSION -

(cat Dockerfile-dev-base; cat dev-ruby) | $DOCKER_BUILDX --build-arg='RUBY_VERSION=2.5.1' -t tool2/dev-ruby:2.5.1-$RUBY_BUILD_VERSION_251 -

# (cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.6.6' -t tool2/dev-ruby:2.6.6-$RUBY_BUILD_VERSION_266 -
#
# (cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.7.4' -t tool2/dev-ruby:2.7.4-$RUBY_BUILD_VERSION_274 -
#
# (cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=2.7.5' -t tool2/dev-ruby:2.7.5-$RUBY_BUILD_VERSION_275 -
#
# (cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=3.0.2' -t tool2/dev-ruby:3.0.2-$RUBY_BUILD_VERSION_302 -
#
# (cat Dockerfile-dev-base; cat dev-ruby) | docker build --build-arg='RUBY_VERSION=3.2.2' -t tool2/dev-ruby:3.2.2-$RUBY_BUILD_VERSION_322 -

echo done.
