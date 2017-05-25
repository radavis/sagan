class Quote < ActiveRecord
  class << self
    def all
      client.query("select * from quotes;", symbolize_keys: true).
        to_a.
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
