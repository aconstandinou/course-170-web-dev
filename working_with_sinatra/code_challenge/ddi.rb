require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "Files Directory"
  @files = Dir.entries(Dir.pwd).select { |f| File.file?(f) }
  @files.reverse! if params[:sort] == "desc"
  erb :index
end
