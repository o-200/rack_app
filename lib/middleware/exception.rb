# frozen_string_literal: true

module Middleware
  class Exception
    attr_reader :app

    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue StandardError => e
      unless env["logger"].nil?
        env["logger"].error(e.message)
        env["logger"].error(e.backtrace)
      end

      [500, { "content-type" => env["CONTENT_TYPE"] }, [""]]
    end
  end
end
