require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "sinatra/content_for"

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
  if !(1..100).cover? name.size
    "List name must be between 1 and 100 characters."
  elsif session[:lists].any? {|list| list[:name] == name}
    "List name must be unique."
  end
end

# Return an error message if the name is invalid. Return nil if name is valid.
def error_for_todo(name)
  if !(1..100).cover? name.size
    "Todo name must be between 1 and 100 characters."
  end
end

# Create a new list
post "/lists" do
  list_name = params[:list_name].strip
  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :new_list, layout: :layout
  else
    session[:lists] << {name: list_name, todos: []}
    session[:success] = "The list has been created."
    redirect "/lists"
  end
end

# View a single todo list
get "/lists/:id" do
  # remember that parameters are strings, so as we try to index the list
  #    number in out list as an index, it needs to be converted to an integer
  @list_id = params[:id].to_i
  # using params[:id] as our index
  @list = session[:lists][@list_id]
  erb :list_template, layout: :layout
end

# Edit an existing todo list
get "/lists/:id/edit" do
  id = params[:id].to_i
  @list = session[:lists][id]
  erb :edit_list, layout: :layout
end

# Update existing todo list
post "/lists/:id" do
  list_name = params[:list_name].strip
  id = params[:id].to_i
  @list = session[:lists][id]

  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :edit_list, layout: :layout
  else
    @list[:name] = list_name
    session[:success] = "The list name has been updated."
    redirect "/lists/#{params[:id]}"
  end
end

post "/lists/:id/destroy" do
  id = params[:id].to_i
  session[:lists].delete_at(id)
  session[:success] = "The list has been removed."
  redirect "/lists"
end

# Add a new todo to a list
post "/lists/:list_id/todos" do
  @list_id = params[:list_id].to_i
  @list = session[:lists][@list_id]
  todo_text = params[:todo].strip

  error = error_for_todo(todo_text)
  if error
    session[:error] = error
    erb :list_template, layout: :layout
  else
    @list[:todos] << {name: todo_text, completed: false}
    session[:success] = "The todo has been added to list."
    redirect "/lists/#{@list_id}"
  end
end

# Delete a todo from list
post "/lists/:list_id/todos/:id/destroy" do
  @list_id = params[:list_id].to_i
  @list = session[:lists][@list_id]

  todo_id = params[:id].to_i
  @list[:todos].delete_at(todo_id)
  session[:success] = "The todo has been removed from list."
  redirect "/lists/#{@list_id}"
end

# Update status of todo
post "/lists/:list_id/todos/:id" do
  @list_id = params[:list_id].to_i
  # finds current list in sessions array
  @list = session[:lists][@list_id]

  todo_id = params[:id].to_i
  is_completed = params[:completed] == "true"
  @list[:todos][todo_id][:completed] = is_completed

  session[:success] = "The todo status has been updated."
  redirect "/lists/#{@list_id}"
end
