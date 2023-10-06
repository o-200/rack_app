module Middleware
  class AssetBuilder
    def initialize(app)
      @app = app
    end

    def call(env)
      path = env["REQUEST_PATH"]
      if is_get?(env) && on_public?(path)
        env["response"] = render(path)
      else
        env["status"] = 404
      end

      @app.call(env)
    end

    def on_public?(path)
      path.split("/")[1] == "public"
    end

    def render(path)
      File.read(".#{path}")
    end

    def is_get?(env)
      env["REQUEST_METHOD"] == "GET"
    end
  end
end
