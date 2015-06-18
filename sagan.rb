require "csv"
require "sinatra"
require "uri"
require "pry"

def at_work?
  t = Time.now
  start_time = Time.local(t.year, t.month, t.day, 7, 30)
  end_time = Time.local(t.year, t.month, t.day, 17, 30)

  if (1..5).include?(t.wday) && t.between?(start_time, end_time)
    return true
  end

  return false
end

def csv_file
  if at_work?
    return "work.csv"
  else
    return "home.csv"
  end
end

def csv_options
  {
    col_sep: "; ",
    headers: true,
    header_converters: :symbol
  }
end

def links(filename = csv_file)
  result = []
  CSV.foreach(filename, csv_options) do |row|
    link = row.to_hash
    link[:hostname] = URI(link[:url]).hostname
    result << link
  end
  result.sort_by { |link| link[:title].downcase }
end

get "/" do
  redirect to("/links")
end

get "/links" do
  erb :"links/index", locals: { links: links }
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
