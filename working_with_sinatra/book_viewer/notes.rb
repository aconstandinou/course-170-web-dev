######################### Sinatra and Web Frameworks #########################

Sinatra Readme: http://sinatrarb.com/intro.html

- Lets sort out TCP to Rack to WEBrick to Sinatra, and how they relate to
  each other.

- Sinatra is a Rack-based web dev framework.
- Since its a Rack-based web dev framework, that implies that it uses Rack to connect
  to a web server like WEBrick.
- Sinatra provides conventions for where to place your application code.
- It has built-in capabilities for routing, view templates, and other features.
- At its core, its nothing more than Ruby code connecting to a TCP server, handling
  requests and sending back responses all in an HTTP-compliant string format.

                                  -------------------  request       response
      ----------------------------                        |             ^
server                                                    V             |
      ----------------------------                           WEBrick
                                  -------------------  [------------------]
                                                       [       [RACK]     ]
                                                       [ SINATRA FRAMEWORK]
                                                       [------------------]

############################## How Routes Work ##############################

- Sinatra provides DSL for defining routes and these routes are how a developer
  maps a URL pattern to some Ruby code.
- in our book_viewer.rb code;

1| require "sinatra"
2| require "sinatra/reloader"
3|
4| get "/" do
5|   File.read "public/template.html"
6| end

1) First, we 'require' 'sinatra' and 'sinatra/reloader' which causes the app to
   reload its files every time we load a page.
2) 'get "/" do' is declaring a route that matches the URL "/". When a user visits that
   path on the app, Sinatra will execute this code block. Value returned is then
   sent to users browser.
   In this case, it contains HTML code

############################ Rendering Templates ############################

- So far, this app is acting like a static file server since its just sending back
  static files back to the user.

- Templates (a.k.a view templates) are files that contain text that is converted
  into HTML before being sent to a users browser in a response.

- Our language of choice "ERB" (embedded Ruby) which is also the default language
  in Ruby on Rails.

ERB example of printing a dynamic value;

<h1><%= @title %></h1>

When the template is rendered, the value for @title will replace the ERB tags.
If @title == "Book Viewer", the rendered output of the template would be:

<h1>Book Viewer</h1>

- Any Ruby code at all can be placed in an .erb file by including it between
  # <% and %>
  If you want to display a value, you have to use a special start tag, <%=


# To use the HTML template in the project as an ERB template instead, perform the following:

1. Copy the code from public/template.html to views/home.erb.
2. Add require "tilt/erubis" to the top of book_viewer.rb.
3. Update the code inside get "/" to;

get "/" do
  erb :home
end

4. Refresh your browser. Nothing should have changed yet.
5. Try modifying erb :home to specify a nonexistent view template, something like erb
   :anything. Reload your browser and look at the error that it displays.
6. Add a dynamic value to the page. Replace the title tag in views/home.erb with a
   value that is defined in the get "/" route.

   <title><%= @title %></title>

7. [Q]: (bonus) What is tilt (referenced in point no. 2 above)
   [A]: allows us to render templates and erubis is a fast alternative to ERB

############################# Table of Contents #############################

- Lets add table of contents that lists the chapters in the book.
- File "data/toc.txt" contains all the chapters in book.

# A Scandal in Bohemia
# The Red-headed League
# A Case of Identity
# The Boscombe Valley Mystery
# The Five Orange Pips
# The Man with the Twisted Lip
# The Adventure of the Blue Carbuncle
# The Adventure of the Speckled Band
# The Adventure of the Engineer's Thumb
# The Adventure of the Noble Bachelor
# The Adventure of the Beryl Coronet
# The Adventure of the Copper Beeches

1. Load the contents of this file into an instance variable within "get '/'' " route.
   Answer
   get "/" do
     @title = "The Adventures of Sherlock Holmes"
     @contents = File.read("data/toc.txt")
     erb :home
   end

2. Display this value in the main content area by adding some code to 'views/home.erb'
<ul class="pure-menu-list">
  <% @contents.each do |chapter| %>
    <li class="pure-menu-item">
      <a href="#" class="pure-menu-link"><%= chapter %></a>
    </li>
  <% end %>
</ul>

3. Would be better to have an Array of Strings where each element in the array
   was the name of a chapter. Update the code that loads the data to do this.
   #we use readlines
   @contents = File.readlines("data/toc.txt")

4. Now update "views/home.erb" to loop through this array of chapter names in two places;
   main content area ( <div id="main"> ) and navigation area ( <div id="menu"> ).

############################# Adding a Chapter Page #############################

- lets start with chapter 1.
- route (aka path) = "/chapters/1"

  Step 1. add a new route to the application, inside it load 'data/chp1.text' into an instance variable.
  get "/chapters/1" do
    @title = "Chapter 1"
    @contents = File.readlines("data/toc.txt")
    @chapter = File.read("data/chp1.txt")

    erb :chapter
  end
  Step 2. Copied 'views/home.erb' over to 'views/chapter.erb' and updated new erb file
          to display our chapter 1 text, after instantiating a new variable @chapter

  Step 3. Adjust paths in stylesheet 'link' tags in 'views/chapter' to have CSS files
          loaded properly.

  (Bonus). The chapter text is not very legible right now.
           Well come back to this in a future assignment, but can you think of a
           way to improve its display?

################################ USING LAYOUTS ################################

- there was a lot of duplication between chapter.erb and home.erb (views directory)
- to alleviate this, we created a 'layout.erb' file within same directory that if
  present, will override the other files.
- key here was to introduce yield on line 39, and indicates where the content
  from the view template will end up.

new files

# "views/home.erb"
=begin
<h2 class="content-subhead">Table of Contents</h2>

<div class="pure-menu">
  <ul class="pure-menu-list">
    <% @contents.each do |chapter| %>
      <li class="pure-menu-item">
        <a href="#" class="pure-menu-link"><%= chapter %></a>
      </li>
    <% end %>
  </ul>
</div>

# "chapter.erb"
<h2 class="content-subhead">Chapter 1</h2>

<%= @chapter %>
=end
################################ ROUTE PARAMETERS ################################

- now we need to add each chapter to our book.
Step 1) add new routes and that requires a lot of duplication
with Sinatra this...

get "chapters/1" do end
get "chapters/2" do end
get "chapters/3" do end

can be replaced with this...

get "/chapters/:number" do end

This will match any route that starts with "/chapters/" followed by a single
  segment. This segment will be an identifier to indicate which chapter to view.
  Values passed to the application through the URL in this way appear in the
  params Hash that is automatically made available in routes

  get "/chapters/:number" do
    @contents = File.readlines("data/toc.txt")

    number = params[:number]
    @title = "Chapter #{number}"

    @chapter = File.read("data/chp#{number}.txt")

    erb :chapter
  end

Update the links in views/layout.erb and views/home.erb to link to the new book pages.

<ul class="pure-menu-list">
  <% @contents.each_with_index do |chapter, index| %>
    <li class="pure-menu-item">
      <a href="/chapters/<%= index + 1 %>" class="pure-menu-link"><%= chapter %></a>
    </li>
  <% end %>
</ul>

Lets display each chapters title on the chapter page and in the pages title.
  Make any changes to book_viewer.rb and views/chapter.erb needed in order to do this.

    # Change #1
    # <!-- views/chapter.erb -->
    <h2 class="content-subhead"><%= @title %></h2>

    #<%= @chapter %>

    # Change #2
    # book_viewer.rb
    get "/chapters/:number" do
      @contents = File.readlines("data/toc.txt")

      number = params[:number].to_i
      chapter_name = @contents[number - 1]
      @title = "Chapter #{number}: #{chapter_name}"

      @chapter = File.read("data/chp#{number}.txt")

      erb :chapter
    end

################################ BEFORE FILTERS ################################

- notice that we are loading the table of contents in both of our routers.
get "/" do
  ...
  @contents = File.readlines("data/toc.txt")
  ...

get "/chapter/:number" do
  @contents = File.readlines("data/toc.txt")
  ...

- we can move this code into a 'before' filter so that we only define it once.
- Sinatra will run the code in a 'before' filter before running code in matching
  route.

  before do
    @contents = File.readlines("data/toc.txt")
  end

- code in 'before' filters run before all routes, instance variables defined
  within it are usually not dependent on which route is being executed

################################ VIEW HELPERS ################################

- so far, none of our whitespace is being used, and chapters are loaded in as
  full texts with no whitespace.

- 'helper' or 'view helper' come into play. These are methods made available in templates
  by Sinatra for the purpose of filtering data, processing data or performing some
  other functionality.

ex:
helpers do
  def slugify(text)
    text.downcase.gsub(/\s+/, "-").gsub(/[^\w-]/, "")
  end
end

This can be used like any other method in a template (assuming @title == "Today is the Day"):
<a href="/articles/<%= slugify(@title) %>"><%= @title %></a>

And will render the expected output:
<a href="/articles/today-is-the-day">Today is the Day</a>

1. Create a helper method called in_paragraphs. This method should take a
   string that is the chapter content and return the same string with paragraph
   tags wrapped around each non-empty line.

It should turn this:
"Frequently."

"How often?"

"Well, some hundreds of times."

into this:

<p>"Frequently."</p>

<p>"How often?"</p>

<p>"Well, some hundreds of times."</p>

Hint: Split the chapter text using two linebreaks ("\n\n").

# Step 1
helpers do
  def in_paragraphs(text)
    text.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end
end

# Step 2
# within chapter.erb
=begin
<h2 class="content-subhead"><%= @title %></h2>

<%= in_paragraphs(@chapter) %>
=end
################################ REDIRECTING ################################

- Goal to learn two things;
1. How Sinatra handles requests for paths it doesnt have a route for
2. How to redirect a user to another path

- when reaching the failed page of a Sinatra app. We get the error
"Sinatra doesn't know this ditty."
"Try this: ...."

- Essentially its giving us a chance to copy and paste a new route into our main
  app file.

- Sinatra also provides a special route, 'not_found', that will be executed whenever
  it cant find any other route to match an incoming request.

  not_found do
    "That page was not found"
  end

- Routes dont have to return HTML code that will be returned to users browser.
  They can also send the browser to a different URL using the 'redirect' method

redirect "/a/good/path"

- 'redirect' method sets the Location header in the HTTP response that is sent
  back to the client, as well as the status code to a value in the range of 3XX,
  signifying redirection; codes 301 and 302 are the most commonly used for redirection
  ... browser confirms that the correct status 3XX status code is there,
      looks at the value of this header, and then uses that header value to
      navigate to a new URL.

- Lets do the same, add code to book_viewer.rb to accomplish this.

  # Not found redirect
  not_found do
    redirect "/"
  end

- There are also instances where we have to handle edge cases when accessing an existing route.
  ex: if we try and access a non-existen book chapter, its not that it is an unknown path
      as it is a semantically incorrect path.
      Possible fix;

get "/chapters/:number" do
  ...
  redirect "/" unless (1..@contents.size).cover? number
  ...
end




.
