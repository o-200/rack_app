# frozen_string_literal: true

RSpec.describe Middleware::Exception do
  subject(:middleware) { described_class.new(app) }

  let(:app) { double(call: [200, {}, ["Hello, World!"]]) }
  let(:env) { { "REQUEST_METHOD" => "GET", "REQUEST_PATH" => "/", "CONTENT_TYPE" => "text/plain" } }
  let(:response) { middleware.call(env) }

  it "should pass the valid access" do
    expect(response).to eq([200, {}, ["Hello, World!"]])
  end

  it "should give 500 status code when app raise exception" do
    allow(app).to receive(:call).and_raise(StandardError)
    expect(response).to eq([500, { "content-type" => "text/plain" }, [""]])
  end
end
