# frozen_string_literal: true

require "rubygems"
require "bundler"
Bundler.require

require "./lib/app"
require "./lib/middleware"

use Rack::Reloader
# use Middleware::ConsoleLogger
# use Middleware::AssetBuilder
use Middleware::StatusError

run HelloWorld.new
