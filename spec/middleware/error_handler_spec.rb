# frozen_string_literal: true

describe Middleware::ErrorHandler do
  let(:app) { double(call: [200, {}, ["Hello, World!"]]) }
  let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/public/testfile.txt" } }
  subject(:middleware) { described_class.new(app) }
  let(:response) { middleware.call(env) }
  let(:body)     { response[2][0] }

  context "get to /public/testfile.txt" do
    it "should pass the valid access" do
      expect(body).to eq("Hello, World!")
    end
  end

  describe "error:" do
    context "receive the 404 status code" do
      let(:app) { double(call: [404, {}, ["Hello, World!"]]) }

      it "should render 404 status code page" do
        expect(body).to eq(File.read("./public/404.html"))
      end
    end

    context "receive the 500 status code" do
      let(:app) { double(call: [500, {}, ["Hello, World!"]]) }

      it "should render 500 status code page" do
        expect(body).to eq(File.read("./public/500.html"))
      end
    end
  end
end
