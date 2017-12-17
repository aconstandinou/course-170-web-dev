# to continue
1) set up all our code files:
  - app.rb
  - config.ru
  - Gemfile
  - Gemfile.lock

# LS Answer
-------------------------------------------------------------------------------
# list.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir.glob("public/*").map {|file| File.basename(file) }.sort
  @files.reverse! if params[:sort] == "desc"
  erb :list
end

#<!-- views/list.erb -->
<ul>
  <% @files.each do |file| %>
    <li>
      <a href="<%= file %>"><%= file %></a>
    </li>
  <% end %>
</ul>

<p>
  <% if params[:sort] == "desc" %>
    <a href="/">Sort ascending</a>
  <% else %>
    <a href="/?sort=desc">Sort descending</a>
  <% end %>
</p>
-------------------------------------------------------------------------------
# A few things to note in the code
# 1. keep in mind that every time we load a page we are re-calling the above code.
# 2. descending is defined in the URL, hence why in our route, we check the parameter
#    hash to see if we are sort = "desc"
#    When it is clicked we actually see this in the url
     http://localhost:4567/?sort=desc
# 3. ascending is default unless we add in the key/value pair in URL
     http://localhost:4567/
# 4. #2 and #3 all come together in our HTML code.
#    Notice how if params[:sort] == "desc" our button shows sort ascending
#    and vice versa. This is
# 5. <a href=> attribute specifies the linked document, resource, or location.
#    Without the leading '/', a URL is relative to the current page location
#      and not the top level. So we include leading slash in our case.
#    Button? Well by adding a href tags, with Sort descending adds the link to the href
#            path and also a link to the HTML page.
