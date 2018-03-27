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
  erb :index
end

get "/:filename" do
  file_exists_bool = file_exists?(params[:filename])

  if file_exists_bool
    file_path = @root + "/data/" + params[:filename]
    if File.extname(file_path) == ".md"
      render_markdown(File.read(file_path))
    else
      headers["Content-Type"] = "text/plain"
      File.read(file_path)
    end
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end

end

get "/:filename/edit" do
  file_path = @root + "/data/" + params[:filename]
  @loaded_file = File.read(file_path)
  erb :edit
end

post "/:filename" do
  file_path = @root + "/data/" + params[:filename]
  File.open(file_path, 'w') { |file| file.write(params[:edited_doc]) }
  session[:message] = "#{params[:filename]} has been changed."
  redirect "/"
end
