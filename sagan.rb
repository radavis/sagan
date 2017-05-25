require "pry"
require "sinatra"
require "uri"
require_relative "./models/category"
require_relative "./models/link"
require_relative "./models/quote"

before { @quote = Quote.all.sample }

get "/" do
  redirect to("/categories")
end

get "/categories" do
  erb :"categories/index",
    locals: {
      links: Link.all,
      categories: Category.all
    }
end

get "/links/new" do
  erb :"links/new", locals: { categories: Category.all }
end

get "/categories/:name/links" do |name|
  category = Category.new(name)
  erb :"links/index", locals: { links: category.links }
end

post "/links" do
  link = Link.new(params[:link])
  if link.save
    # flash[:notice] = "Link added."
    redirect to("/categories")
  else
    # flash[:error] = "There was a problem..."
    erb :"links/new", locals: { categories: Category.all }
  end
end
