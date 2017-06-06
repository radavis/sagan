RSpec.describe "Sagan" do
  describe "GET /categories" do
    it "responds with its name" do
      get "/categories"
      expect(last_response.body).to include("Sagan")
    end
  end

  describe "POST /links" do
    it "accepts POST requests with url and title" do
      post "/links", link: {
        url: "https://keep.google.com",
        title: "Google Keep",
        description: "note taking app",
        category: "webapp"
      }
      expect(last_response).to be_a_redirect
    end
  end
end
