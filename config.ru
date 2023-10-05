# frozen_string_literal: true

require "rubygems"
require "bundler"
Bundler.require

require "./lib/app"

use Rack::Reloader

run HelloWorld.new
