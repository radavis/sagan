require 'yaml'

class ActiveRecord
  class << self
    def config
      filename = File.join(File.dirname(__FILE__), "..", "config", "database.yml")
      @_config ||= YAML.load_file(filename)
    end

    def application_config
      config[environment.to_s]
    end

    def database_name
      application_config["database"]
    end

    def query(sql, values = [])
      escaped_sql = escape_query(sql, values)
      client.query(escaped_sql, options).to_a
    end

    def last_insert_id
      query("select last_insert_id()").first["last_insert_id()"]
    end

    private

    def client
      @_client ||= Mysql2::Client.new(application_config)
    end

    def options
      { symbolize_keys: true }
    end

    def environment
      Sinatra::Application.environment
    end

    def escape_query(sql, values)
      values.map! { |value| Mysql2::Client.escape(value) }
      parts = sql.split("?")
      result = ""
      parts.each_with_index do |part, i|
        result += part
        result += "'#{values[i]}'" unless i == parts.size - 1
      end
      return result
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
