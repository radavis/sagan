require "csv"
require "sinatra"
require "uri"

def path
  File.expand_path(File.dirname(__FILE__))
end

def filenames
  Dir[File.join(path, "links", "*.csv")]
end

def category_files
  result = {}
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

def all_links
  results = {}
  category_files.each do |category, filename|
    results[category] = links(filename)
  end
  results
end

get "/" do
  redirect to("/categories")
end

get "/categories" do
  erb :"categories/index", locals: { links: all_links }
end

get "/links/new" do
  erb :"links/new", locals: { categories: category_files.keys }
end

get "/links/:category" do |category|
  filename = File.join(path, "links", "#{category}.csv")
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
