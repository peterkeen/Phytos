# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'girl_friday/server'

run Rack::URLMap.new \
  '/' => Phytos::Application,
  '/_gf' => GirlFriday::Server.new
