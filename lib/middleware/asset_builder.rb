# frozen_string_literal: true

module Middleware
  class AssetBuilder
    def initialize(app)
      @app = app
    end

    def call(env)
      path = make_safe_path(env["PATH_INFO"])
      status, headers, body = @app.call(env)

      if on_public?(path) && file_exists?(path)
        return Rack::Response.new(read_file(path)).finish
      else
        env["logger"]&.error("404 Page Not Found")
        status = 404
      end

      [status, headers, body]
    end

    private

    def read_file(path)
      File.read(".#{path}")
    end

    def make_safe_path(path)
      path.gsub("/..", "")
    end

    def on_public?(path)
      path.split("/")[1] == "public"
    end

    def file_exists?(path)
      File.exist?(".#{path}")
    end
  end
end
