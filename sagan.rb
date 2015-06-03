require "csv"
require "sinatra"
require "uri"

def links
  result = []
  csv_options = {
    col_sep: "; ",
    headers: true,
    header_converters: :symbol
  }
  CSV.foreach("links.csv", csv_options) do |row|
    link = row.to_hash
    link[:hostname] = URI(link[:url]).hostname
    result << link
  end
  result
end

def sorted_links
  links.sort_by { |link| link[:title].downcase }
end

get "/" do
  redirect to("/links")
end

get "/links" do
  erb :links, locals: { links: sorted_links }
end
