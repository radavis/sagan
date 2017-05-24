require "sinatra"
require "uri"
require_relative "./models/link"
require_relative "./models/category"

def csv_options
  {
    col_sep: "; ",
    headers: true,
    header_converters: :symbol
  }
end

before do
  @quote = File.readlines("quotes", csv_options).sample.chomp
end

get "/" do
  redirect to("/categories")
end

get "/categories" do
  erb :"categories/index", locals: { links: Link.all, categories: Category.all }
end

get "/links/new" do
  erb :"links/new", locals: { categories: category_files.keys }
end

get "/links/:category" do |category|
  filename = File.join(path, "links", "#{category}.csv")
  erb :"links/index", locals: { links: links(filename) }
end

# post "/links" do
#   link = params[:link]
#   basename = link[:category]
#   filename = File.join(path, "links", "#{basename}.csv")
#   CSV.open(filename, "a", csv_options) do |csv|
#     csv << [link[:url], link[:title], link[:description]]
#   end
#   redirect to("/categories")
# end
