# frozen_string_literal: true

require "logger"

module Middleware
  class Logger
    def initialize(app)
      @app = app
      @logger = ::Logger.new($stdout)
    end

    def call(env)
      env["logger"] = @logger
      @app.call(env)
    end
  end
end
