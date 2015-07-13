require "csv"
require "sinatra"
require "uri"
require "pry"

def csv_files
  result = {}
  path = File.expand_path(File.dirname(__FILE__))
  filenames = Dir[File.join(path, "links", "*.csv")]
  filenames.each do |filename|
    basename = File.basename(filename, ".csv")
    result[basename] = filename
  end
  result
end

def csv_options
  {
    col_sep: "; ",
    headers: true,
    header_converters: :symbol
  }
end

def links(filename)
  results = []
  CSV.foreach(filename, csv_options) do |row|
    link = row.to_hash
    link[:hostname] = URI(link[:url]).hostname
    results << link
  end
  results.sort_by { |link| link[:title].downcase }
end

def csv_links
  results = {}
  csv_files.each do |category, filename|
    results[category] = links(filename)
  end
  results
end

get "/" do
  redirect to("/links")
end

get "/links" do
  erb :"links/index", locals: { links: csv_links }
end

get "/links/new" do
  erb :"links/new"
end

get "/links/:category" do |category|
  filename = "#{category}.csv"
  erb :"links/index", locals: { links: links(filename) }
end

post "/links" do
  link = params[:link]
  basename = link[:category]
  filename = "#{basename}.csv"
  CSV.open(filename, "a", csv_options) do |csv|
    csv << [link[:url], link[:title], link[:description]]
  end
  redirect to("/links")
end
