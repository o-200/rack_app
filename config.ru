# frozen_string_literal: true

require "rubygems"
require "bundler"
Bundler.require

require "./lib/app"
require "./lib/middleware"

use Rack::Reloader

use Middleware::ErrorHandler
use Middleware::Exception
use Middleware::AssetBuilder
use Middleware::Logger

run HelloWorld.new
