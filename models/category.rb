require_relative "active_record"

class Category < ActiveRecord
  class << self
    def all
      sql = "select distinct links.category from links order by links.category;"
      client.query(sql, symbolize_keys: true).
        to_a.
        map { |row| new(row[:category]) }
    end
  end

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  def links
    sql = "select * from links where category = '#{name}';"
    self.class.client.
      query(sql, symbolize_keys: true).
      to_a.
      map { |row| Link.new(row) }
  end
end
