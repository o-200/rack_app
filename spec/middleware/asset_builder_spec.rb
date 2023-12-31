# frozen_string_literal: true

describe Middleware::AssetBuilder do
  let(:app) { double(call: [200, {}, ["Hello, World!"]]) }
  let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/public/testfile.txt" } }
  subject(:middleware) { described_class.new(app) }
  let(:response) { middleware.call(env) }
  let(:body)     { response[2][0] }

  context "get to /public/testfile.txt" do
    it "should read the file" do
      readfile = File.read("./#{env["PATH_INFO"]}")
      expect(body).to eq(readfile)
    end
  end

  context "error scenario" do
    context "path to unaviable file" do
      let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/public/unaviablefile" } }

      it "should give 404 status code" do
        expect(response[0]).to eq(404)
      end
    end

    context "path to not public directory" do
      let(:env) { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/README.mb" } }

      it "should give 404 status code" do
        expect(response[0]).to eq(404)
      end
    end

    context "danger path" do
      let(:env) { { "PATH_INFO" => "/public/../etc/password" } }

      before do
        allow(app).to receive(:call).and_return([200, { "Content-Type" => "text/plain" }, ["OK"]])
      end

      it "does not read the file" do
        expect(File).not_to receive(:read)

        middleware.call(env)
      end
    end
  end
end
