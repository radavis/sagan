require_relative "active_record"

class Link < ActiveRecord
  class << self
    def all
      client.query("select * from links;", symbolize_keys: true).
        to_a.
        map { |link| new(link) }
    end
  end

  attr_reader :id, :url, :title, :description, :category

  def initialize(hash)
    @id = hash[:id]
    @url = hash[:url]
    @title = hash[:title]
    @description = hash[:description]
    @category = hash[:category]
  end

  def hostname
    URI(url).hostname
  end

  def save
    sql = <<-SQL
      insert into links (url, title, description, category)
      values ('#{url}', '#{title}', '#{description}', '#{category}');
    SQL
    self.class.client.query(sql)
  end
end
