# frozen_string_literal: true

RSpec.describe Middleware::Logger do
  let(:app) { double("app") }
  let(:logger) { instance_double(Logger) }
  let(:middleware) { described_class.new(app) }

  describe "#call" do
    let(:env) { { "logger" => "Error message" } }
    let(:response) { [200, {}, []] }

    before do
      allow(app).to receive(:call).with(env).and_return(response)
      allow(Logger).to receive(:new).with($stdout).and_return(logger)
      allow(logger).to receive(:error)
    end

    it "returns the response from the app" do
      expect(middleware.call(env)).to eq(response)
    end

    it "calls the app with the given environment" do
      expect(app).to receive(:call).with(env).and_return(env["logger"])
      middleware.call(env)
    end
  end
end
