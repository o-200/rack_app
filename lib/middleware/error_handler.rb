# frozen_string_literal: true

module Middleware
  class ErrorHandler
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      return Rack::Response.new(readfile("./public/#{status}.html")).finish if [404, 500].include?(status)

      [status, headers, body]
    end

    def readfile(path)
      File.read(path)
    end
  end
end
