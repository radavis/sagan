require_relative "active_record"

class Link < ActiveRecord
  class << self
    def all
      query("select * from links order by links.title").
        map { |link| new(link) }
    end

    def find(id)
      results = query("select * from links where links.id = ? limit 1", [id])
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

  def assign_attributes(hash)
    @url = hash[:url]
    @title = hash[:title]
    @description = hash[:description]
    @category = hash[:category]
  end

  def hostname
    URI(url).hostname
  end

  def save
    if id
      return update
    else
      return create
    end
  end

  def destroy
    sql = "delete from links where links.id = ?"
    self.class.query(sql, [id])
  end

  private

  def create
    sql = <<-SQL
      insert into links (url, title, description, category)
      values (?, ?, ?, ?)
    SQL
    values = [url, title, description, category]
    self.class.query(sql, values)
    true
  end

  def update
    sql = <<-SQL
      update links
      set url = ?, title = ?, description = ?, category = ?
      where id = ?
    SQL
    values = [url, title, description, category]
    self.class.query(sql, values)
    true
  end
end
