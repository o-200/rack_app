describe HelloWorld do
  include Rack::Test::Methods

  context "#GET" do
    let(:app) { HelloWorld.new }

    it "return status code 200" do
      get "/"
      expect(last_response.status).to eq(200)
    end

    it "return body" do
      get "/"
      expect(last_response.body).to eq("Hello, world!")
    end
  end
end
