# frozen_string_literal: true

module Middleware
  class ErrorHandler
    attr_reader :status

    def initialize(app)
      @app = app
    end

    def call(env)
      @status, headers, body = @app.call(env)
      if [404, 500].include?(status)
        return Rack::Response.new(File.read("./public/#{@status}.html")).finish
      end

      [@status, headers, body]
    end
  end
end
