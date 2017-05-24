require_relative "active_record"

class Category < ActiveRecord
  class << self
    def all
      client.query("select distinct category from links;", symbolize_keys: true).
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
    self.class.client.
      query("select * from links where category = '#{name}';", symbolize_keys: true).
      to_a.
      map { |row| Link.new(row) }
  end
end
