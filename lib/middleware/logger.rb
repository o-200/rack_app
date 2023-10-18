# frozen_string_literal: true

require "logger"

module Middleware
  class Logger
    def initialize(app)
      @app = app
      @logger = ::Logger.new($stdout)
    end

    def call(env)
      status, headers, body = @app.call(env)

      @logger.error(env["logger"]) if env["logger"]

      [status, headers, body]
    end
  end
end
