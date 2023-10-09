RSpec.describe Middleware::Logger do
  let(:app) { double("app") }
  let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/" } }
  let(:status) { 200 }
  let(:headers) { { "Content-Type" => "text/plain" } }
  let(:body) { ["Hello, world!"] }
  let(:time) { Time.now }

  subject { described_class.new(app) }

  describe "#call" do
    before do
      allow(app).to receive(:call).with(env).and_return([status, headers, body])
      allow(File).to receive(:directory?).with("logs").and_return(true)
      allow(File).to receive(:open).with("logs/server.log", "a+").and_yield(StringIO.new)
    end

    it "calls the app with the given env" do
      expect(app).to receive(:call).with(env).and_return([status, headers, body])
      subject.call(env)
    end

    it "logs the request and response to a file" do
      expect(File).to receive(:open).with("logs/server.log", "a+").and_yield(StringIO.new)
      subject.call(env, time)
    end

    it "logs the request method, path, and status" do
      expected_message = "[#{time}] \"GET /\" 200\n"
      expect { subject.call(env, time) }.to output(expected_message).to_stdout
    end
  end
end
