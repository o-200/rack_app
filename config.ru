# frozen_string_literal: true

require "rubygems"
require "bundler"
Bundler.require

require "./lib/app"
require "./lib/middleware"

use Rack::Reloader

use Middleware::Logger
use Middleware::ErrorHandler
use Middleware::AssetBuilder
use Middleware::Exception

run HelloWorld.new
