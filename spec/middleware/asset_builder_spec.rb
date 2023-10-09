# frozen_string_literal: true

describe Middleware::AssetBuilder do
  let(:app) { double(call: [200, {}, ["Hello, World!"]]) }
  let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/public/testfile.txt" } }
  subject(:middleware) { described_class.new(app) }
  let(:response) { middleware.call(env) }
  let(:body)     { response[2][0] }

  context "get to /public/testfile.txt" do
    it "can read the file on public directory" do
      expect(body).to eq("hi")
    end
  end

  describe "error scenarios" do
    context "path to folder" do
      let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/public" } }

      it "should give 404 status code" do
        expect(response[0]).to eq(404)
      end
    end

    context "path to unaviable file" do
      let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/public/unaviablefile" } }

      it "should give 404 status code" do
        expect(response[0]).to eq(404)
      end
    end
  end
end
