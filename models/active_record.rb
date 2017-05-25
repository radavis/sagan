require 'mysql2'
require 'yaml'

class ActiveRecord
  class << self
    def config
      filename = File.join(File.dirname(__FILE__), "..", "config", "database.yml")
      @_config ||= YAML.load_file(filename)
    end

    def client
      @_client ||= Mysql2::Client.new(config["development"])
    end
  end
end

<<-NOTES
require 'mysql2'
require 'yaml'

filename = File.join(File.dirname(__FILE__), "config", "database.yml")
config = YAML.load_file(filename)
client = Mysql2::Client.new(config["development"])
client.query("select * from links;", symbolize_keys: true).to_a
NOTES
