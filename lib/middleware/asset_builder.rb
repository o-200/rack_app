module Middleware
  class AssetBuilder
    def call(env)
      @app.call(env)
    end
  end
end
