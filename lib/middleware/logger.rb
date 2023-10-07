module Middleware
  class Logger
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      Dir.mkdir("logs") unless File.directory?("logs")
      File.open("logs/server.log", "a+") do |f|
        message = "[#{Time.now}] \"#{env["REQUEST_METHOD"]} #{env["PATH_INFO"]}\" #{status}\n"
        f.write(message)
        puts message
      end

      [status, headers, body]
    end
  end
end
