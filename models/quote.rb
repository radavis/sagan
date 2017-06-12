require_relative "active_record"

class Quote < ActiveRecord
  class << self
    def all
      query("select * from quotes;").
        map { |quote| new(quote) }
    end
  end

  attr_reader :id, :content

  def initialize(hash)
    @id = hash[:id]
    @content = hash[:content]
  end

  def to_s
    content
  end
end
