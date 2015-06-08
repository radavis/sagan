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

def links
  result = []
  filename = csv_file
  csv_options = {
    col_sep: "; ",
    headers: true,
    header_converters: :symbol
  }
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
  erb :links, locals: { links: links }
end
