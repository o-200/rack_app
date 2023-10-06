module Middleware
  class StatusError
    def initialize(app)
      @app = app
    end

    def call(env)
      if env["status"] == 404 || env["status"] == 500
        return Rack::Response.new(readfile("./public/#{env["status"]}.html")).finish
      end

      @app.call(env)
    end

    def readfile(path)
      File.read(path)
    end
  end
end
