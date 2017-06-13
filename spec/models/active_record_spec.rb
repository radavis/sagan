RSpec.describe ActiveRecord do
  describe ".config" do
    it "loads the database configuration from the config/database.yml file" do
      expect(ActiveRecord.config["test"]["adapter"]).to eq("mysql2")
      expect(ActiveRecord.config["test"]["database"]).to eq("sagan_test")
    end
  end

  describe ".application_config" do
    it "returns the database configuration based on environment" do
      allow(ActiveRecord).to receive(:environment) { :development }
      expect(ActiveRecord.application_config["adapter"]).to eq("mysql2")
      expect(ActiveRecord.application_config["database"]).to eq("sagan_development")

      allow(ActiveRecord).to receive(:environment) { :test }
      expect(ActiveRecord.application_config["database"]).to eq("sagan_test")
    end
  end

  let(:insert_statement) {
    "insert into links (url, title, description, category) values (?, ?, ?, ?);"
  }

  describe ".query" do
    it "takes a query and optional values" do
      values = ["cachemonet.com", "#cachemonet", "the best", "webapp"]
      insert = ActiveRecord.query(insert_statement, values)
      result = ActiveRecord.query("select * from links;")
      expect(result.last[:url]).to eq("cachemonet.com")
    end
  end

  describe ".last_insert_id" do
    it "returns the id of that last inserted record" do
      values = ["exloc.io", "exloc", "code examples", "webapp"]
      insert = ActiveRecord.query(insert_statement, values)
      last_insert_id = ActiveRecord.last_insert_id
      id = ActiveRecord.query("select * from links;").last["id"]
      expect(last_insert_id).to eq(id)
    end
  end
end
