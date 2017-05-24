require_relative "active_record"

class Link < ActiveRecord
  class << self
    def all
      client.query("select * from links;").
        to_a.
        map { |link| new(link) }
    end
  end

  attr_reader :id, :url, :title, :description

  def initialize(hash)
    @id = hash[:id]
    @url = hash[:url]
    @title = hash[:title]
    @description = hash[:description]
  end

  def hostname
    URI(url).hostname
  end
end
