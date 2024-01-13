#!/usr/bin/env ruby
require 'json'
raw_arch = `uname -m`.strip
if raw_arch == "x86_64"
  ARCH = "amd64"
  BUILD = "docker build --platform linux/amd64"
elsif raw_arch == "arm64"
  ARCH = "arm64"
  BUILD = "docker build --platform linux/arm64"
else
  puts "unknown architecture: #{raw_arch}"
  exit 1
end

UNISON_VERSION = "v3"
DEV_BASE_VERSION = "v6"
RUBY_BUILD_VERSION_193 = "v1"
RUBY_BUILD_VERSION_251 = "v3"
RUBY_BUILD_VERSION_266 = "v3"
RUBY_BUILD_VERSION_2610 = "v1"
RUBY_BUILD_VERSION_273 = "v1"
RUBY_BUILD_VERSION_274 = "v3"
RUBY_BUILD_VERSION_275 = "v3"
RUBY_BUILD_VERSION_302 = "v3"
RUBY_BUILD_VERSION_311 = "v1"
RUBY_BUILD_VERSION_322 = "v3"

def is_docker_image_exists?(image, tag)
  hr = JSON.load(`curl -s https://hub.docker.com/v2/repositories/#{image}/tags/#{tag}`)
  !!hr["id"]
end

def docker_build(image, tag, script, build_arg)
  if is_docker_image_exists?(image, tag)
    puts "docker image #{image}:#{tag} already exists"
  else
    puts "start #{image}:#{tag} build:"
    system("#{script} | #{BUILD} #{build_arg ? "--build-arg=#{build_arg}" : ""} -t #{image}:#{tag} -; docker push #{image}:#{tag}")
    raise "script failed" unless $?.success?
  end
end


docker_build("avakhov/unison", "#{UNISON_VERSION}-#{ARCH}", "cat Dockerfile-unison", nil)
docker_build("avakhov/dev-base", "#{DEV_BASE_VERSION}-#{ARCH}", "cat Dockerfile-dev-base", nil)
docker_build("avakhov/dev-ruby", "1.9.3-#{RUBY_BUILD_VERSION_193}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=1.9.3-p551")
docker_build("avakhov/dev-ruby", "2.5.1-#{RUBY_BUILD_VERSION_251}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=2.5.1")
docker_build("avakhov/dev-ruby", "2.6.6-#{RUBY_BUILD_VERSION_266}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=2.6.6")
docker_build("avakhov/dev-ruby", "2.6.10-#{RUBY_BUILD_VERSION_2610}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=2.6.10")
docker_build("avakhov/dev-ruby", "2.7.3-#{RUBY_BUILD_VERSION_273}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=2.7.3")
docker_build("avakhov/dev-ruby", "2.7.4-#{RUBY_BUILD_VERSION_274}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=2.7.4")
docker_build("avakhov/dev-ruby", "2.7.5-#{RUBY_BUILD_VERSION_275}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=2.7.5")
docker_build("avakhov/dev-ruby", "3.0.2-#{RUBY_BUILD_VERSION_302}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=3.0.2")
docker_build("avakhov/dev-ruby", "3.1.1-#{RUBY_BUILD_VERSION_311}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=3.1.1")
docker_build("avakhov/dev-ruby", "3.2.2-#{RUBY_BUILD_VERSION_322}-#{ARCH}", "(cat Dockerfile-dev-base; cat dev-ruby)", "RUBY_VERSION=3.2.2")
puts "done :)"
