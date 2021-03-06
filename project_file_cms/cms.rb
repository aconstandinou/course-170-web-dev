require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "redcarpet"
require "yaml"
require "bcrypt"

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

def user_signed_in?
  session.key?(:username)
end

def require_signed_in_user
  unless user_signed_in?
    session[:message] = "You must be signed in to do that."
    redirect "/"
  end
end

get "/" do
  pattern = File.join(data_path, "*")
  @files = Dir.glob(pattern).map do |path|
    File.basename(path)
  end
  erb :index, layout: :layout
end

def load_file_content(path)
  content = File.read(path)
  case File.extname(path)
  when ".txt"
    headers["Content-Type"] = "text/plain"
    content
  when ".md"
    erb render_markdown(content)
  end
end

def load_users_credentials
  credentials_path = if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/users.yml", __FILE__)
  else
    File.expand_path("../users.yml", __FILE__)
  end
  YAML.load_file(credentials_path)
end


def valid_credentials?(username, password)
  credentials = load_users_credentials

  if credentials.key?(username)
    bcrypt_password = BCrypt::Password.new(credentials[username])
    bcrypt_password == password
  else
    false
  end
end


get "/:filename" do
  file_path = File.join(data_path, File.basename(params[:filename]))

  if file_exists?(params[:filename])
    load_file_content(file_path)
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

get "/:filename/edit" do
  require_signed_in_user

  file_path = File.join(data_path, params[:filename])
  @loaded_file = File.read(file_path)
  erb :edit, layout: :layout
end

post "/:filename" do
  require_signed_in_user

  file_path = File.join(data_path, params[:filename])
  File.write(file_path, params[:edited_doc])
  session[:message] = "#{params[:filename]} has been changed."
  redirect "/"
end

get "/create/document" do
  require_signed_in_user
  erb :create
end

post "/create/document" do
  require_signed_in_user

  filename = params[:new_doc_name].to_s

  if filename.size == 0
    session[:message] = "A name is required."
    status 422
    erb :create
  else
    file_path = File.join(data_path, filename)
    File.open(file_path, "w+")
    session[:message] = "#{params[:new_doc_name]} has been created."
    redirect "/"
  end
end

post "/delete/:filename" do
  require_signed_in_user

  file_path = File.join(data_path, params[:filename])
  File.delete(file_path)
  session[:message] = "#{params[:filename]} was deleted."
  redirect "/"
end

get "/users/signin" do
  erb :signin
end

post "/users/signin" do
  username = params[:username]

  if valid_credentials?(username, params[:password])
    session[:username] = params[:username]
    session[:message] = "Welcome!"
    redirect "/"
  else
    session[:message] = "Invalid credentials"
    status 422
    erb :signin
  end
end

post "/users/signout" do
  session.delete(:username)
  session[:message] = "You have been signed out."
  redirect "/users/signin"
end
