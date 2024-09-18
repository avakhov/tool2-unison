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

ELASTIC_243 = "v6"
DEV_BASE  = "v8"
RUBY_251  = "v4"
RUBY_266  = "v4"
RUBY_2610 = "v2"
RUBY_273  = "v2"
RUBY_274  = "v4"
RUBY_275  = "v4"
RUBY_302  = "v4"
RUBY_311  = "v2"
RUBY_322  = "v4"

def is_docker_image_exists?(image, tag)
  puts("cmd: curl -s https://hub.docker.com/v2/repositories/#{image}/tags/#{tag}")
  hr = JSON.load(`curl -s https://hub.docker.com/v2/repositories/#{image}/tags/#{tag}`)
  !!hr["id"]
end

def docker_build(image, tag, files)
  if is_docker_image_exists?(image, tag)
    puts "docker image #{image}:#{tag} already exists"
  else
    puts "start #{image}:#{tag} build ..."
    system("cd dockerfiles && (#{Array(files).map{|f| "cat #{f}"}.join("; ")}) | #{BUILD} -t #{image}:#{tag} - && docker push #{image}:#{tag}")
    raise "script failed" unless $?.success?
  end
end

docker_build("avakhov/elasticsearch", "2.4.3-#{ELASTIC_243}-#{ARCH}", "elastic_243")
docker_build("avakhov/dev-base", "#{DEV_BASE}-#{ARCH}", "dev_base")
docker_build("avakhov/dev-ruby", "2.5.1-#{RUBY_251}-#{ARCH}", ["dev_base", "ruby251"])
docker_build("avakhov/dev-ruby", "2.6.6-#{RUBY_266}-#{ARCH}", ["dev_base", "ruby266"])
docker_build("avakhov/dev-ruby", "2.6.10-#{RUBY_2610}-#{ARCH}", ["dev_base", "ruby2610"])
docker_build("avakhov/dev-ruby", "2.7.3-#{RUBY_273}-#{ARCH}", ["dev_base", "ruby273"])
docker_build("avakhov/dev-ruby", "2.7.4-#{RUBY_274}-#{ARCH}", ["dev_base", "ruby274"])
docker_build("avakhov/dev-ruby", "2.7.5-#{RUBY_275}-#{ARCH}", ["dev_base", "ruby275"])
docker_build("avakhov/dev-ruby", "3.0.2-#{RUBY_302}-#{ARCH}", ["dev_base", "ruby302"])
docker_build("avakhov/dev-ruby", "3.1.1-#{RUBY_311}-#{ARCH}", ["dev_base", "ruby311"])
docker_build("avakhov/dev-ruby", "3.2.2-#{RUBY_322}-#{ARCH}", ["dev_base", "ruby322"])

puts "done :)"
