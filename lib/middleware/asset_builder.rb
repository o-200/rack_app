# frozen_string_literal: true

module Middleware
  class AssetBuilder
    def initialize(app)
      @app = app
    end

    def call(env)
      path = env["PATH_INFO"]
      status, headers, body = @app.call(env)

      if on_public?(path) && file_exists?(path)
        return Rack::Response.new(render(path)).finish
      else
        status = 404
      end

      [status, headers, body]
    end

    private

    def on_public?(path)
      path.split("/")[1] == "public"
    end

    def file_exists?(path)
      File.exist?(".#{path}") && File.file?(".#{path}")
    end

    def render(path)
      File.read(".#{path}")
    end
  end
end
