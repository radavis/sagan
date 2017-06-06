require "sinatra"
require "bundler/setup"
Bundler.require(:default, Sinatra::Application.environment)

require_relative "./lib/current_time"
require_relative "./models/category"
require_relative "./models/link"
require_relative "./models/quote"

enable :sessions
use Rack::Flash

before do
  @work_category = "workbar"
  @quote = Quote.all.sample
end

get "/" do
  if CurrentTime.new.working_hours?
    redirect to("/categories/#{@work_category}/links")
  else
    redirect to("/categories")
  end
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
    flash[:notice] = "Link added."
    redirect to("/categories")
  else
    flash[:error] = "There was a problem..."
    erb :"links/new", locals: { categories: Category.all }
  end
end

delete "/links/:id" do |id|
  link = Link.find(id)
  link.destroy
  status 200
end
