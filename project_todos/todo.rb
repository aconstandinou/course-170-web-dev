require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

# to track our todos in a user session
configure do
  # telling sinatra to enable sessions
  enable :sessions
  # set to string secret, in production app, it would be much longer
  set :session_secret, 'secret'
end

# this prevented the load error from happening where we call .each method on empty
# list. Before anything is loaded, we create an empty list in our session
before do
  session[:lists] ||= []
end

get "/" do
  redirect "/lists"
end

# names of routes can be quite arbitrary
#   using lists in our routes, sets a certain pattern to illustrate what we are
#   modifying or viewing
# GET  /lists      -> view all lists
# GET  /lists/new  -> new list form
# POST /lists      -> create new list
# GET  /lists/1    -> view a single list (route ends with id for list)

# View list all the lists
get "/lists" do
  @lists = session[:lists]
  # implies we will have an erb template called lists
  erb :lists, layout: :layout
end

# Render new list form
get "/lists/new" do
  erb :new_list, layout: :layout
end

# Return an error message if the name is invalid. Return nil if name is valid.
def error_for_list_name(name)
  error_to_ret = nil
  if !(1..100).cover? name.size
    error_to_ret = "List name must be between 1 and 100 characters."
  elsif session[:lists].any? {|list| list[:name] == name}
    error_to_ret = "List name must be unique."
  end
  error_to_ret
end

# Create a new list
post "/lists" do
  list_name = params[:list_name].strip

  if error = error_for_list_name(list_name)
    session[:error] = error
    erb :new_list, layout: :layout
  else
    session[:lists] << {name: list_name, todos: []}
    session[:success] = "The list has been created."
    redirect "/lists"
  end
end
