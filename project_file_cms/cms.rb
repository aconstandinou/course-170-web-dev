require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "redcarpet"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

def render_markdown(text_to_render)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(text_to_render)
end

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end

before do
  @root = File.expand_path("..", __FILE__)
  @files = Dir.glob(@root + "/data/*").map do |path|
    File.basename(path)
  end
end

def file_exists?(f_name)
  @files.include?(f_name)
end

get "/" do
  pattern = File.join(data_path, "*")
  @files = Dir.glob(pattern).map do |path|
    File.basename(path)
  end
  erb :index, layout: :layout
end

get "/:filename" do
  file_path = File.join(data_path, params[:filename])
  content = File.read(file_path)

  if file_exists?(params[:filename])
    if File.extname(file_path) == ".md"
      render_markdown(content)
    else
      headers["Content-Type"] = "text/plain"
      content
    end
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

get "/:filename/edit" do
  file_path = File.join(data_path, params[:filename])
  @loaded_file = File.read(file_path)
  erb :edit, layout: :layout
end

post "/:filename" do
  file_path = File.join(data_path, params[:filename])
  File.write(file_path, params[:edited_doc])
  session[:message] = "#{params[:filename]} has been changed."
  redirect "/"
end

get "/create/document" do
  erb :create
end

post "/create/document" do
  file_path = File.join(data_path, params[:new_doc_name])
  File.open(file_path, "w+")
  session[:message] = "#{params[:new_doc_name]} has been created."
  redirect "/"
end
