require_relative "active_record"

class Link < ActiveRecord
  class << self
    def all
      client.query("select * from links order by links.title;", symbolize_keys: true).
        to_a.
        map { |link| new(link) }
    end

    def find(id)
      results = client.query("select * from links where links.id = #{id} limit 1", symbolize_keys: true)
      if results.any?
        return new(results.first)
      else
        return nil
      end
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
    # TODO: escape input
    sql = <<-SQL
      insert into links (url, title, description, category)
      values ('#{url}', '#{title}', '#{description}', '#{category}');
    SQL
    self.class.client.query(sql)
  end

  def destroy
    sql = "delete from links where links.id = #{id}"
    self.class.client.query(sql)
  end
end
