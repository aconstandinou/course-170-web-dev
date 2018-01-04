require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @users_content = YAML.load_file("users.yaml")
end

helpers do
  def count_interests
    total_interests = 0
    @users_content.each do |user, data|
      total_interests += data[:interests].size
    end
    total_interests
  end
end

get "/" do
  @title = "List of Users"
  erb :index
end

# adding a new route for user name
get "/:name" do
  @name = params[:name]
  erb :user
end
