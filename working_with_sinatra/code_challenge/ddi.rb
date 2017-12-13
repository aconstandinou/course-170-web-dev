require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "List of Files"
  @list_files = Dir.entries(Dir.pwd).select { |f| File.file?(f) }

  erb :index
end

get "/code_challenge_ddi.rb" do
  @title = "code_challenge_ddi.rb file"
  @file = Dir.entries(Dir.pwd).select { |f| f ==  "code_challenge_ddi.rb" }
  erb :file_read
end
