################################################################################
################################### SINATRA ####################################
################################################################################

Rack-based implies : - uses Rack to connect to a web server, like WEBrick.

Sinatra
- DSL
- built-in capabilities for routing
- view templates

At the core, its Ruby code connecting to a TCP server, handling requests and
  sending back responses all in an HTTP-compliant string format.

#################################### ROUTES ####################################

Routes - how developer maps URL patterns to Ruby code. (aka HTTP requests)
       - created using methods named after HTTP method, ie: GET
       - associated with a block
       - matched in order they are defined

methods list: delete, options, get, put, post, patch, link, unlink

# Sinatra simple breakdown
require "sinatra"           # require our gem library
require "sinatra/reloader"  # causes app to reload files every time we load page

get "/" do                    # declares a route that matches the URL "/"
 File.read "public/template.html"
end

get "/"  # declares a route that matches the URL "/"

When a user visits that path on the application, Sinatra will execute the
  body of the block. The value that is returned by the block is then sent
  to the users browser.

In the example route, were loading the contents of the file at "public/template.html"
  and sending it back to the browser. This file contains the HTML code but appearing as
  a static file.

################################ VIEW TEMPLATES ################################

Benefits?
- View templates allow us to combine HTML and Ruby code.
- Allows us to reduce duplication of HTML as well as generate dynamic content.
- Without view templates, we would end up writing HTML code into each route within
    the string we return in our response.
  And were including dynamic content via string interpolation.

What do they do?

- CONVERT HTML : files that contain text, converted into HTML before being sent to users browser response.
- DYNAMIC : allows our web apps to be more dynamic

- ERB (embeded Ruby)
       - embeds Ruby code into another file.
       - ruby code sites between "<%" and "%>"
       - to display ruby values "<%=" and "%>"

require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"                         # library for erb

get "/" do
  erb :home
end

"LAYOUTS"
- view template that wraps around other view templates.
- shared HTML code in a layout, and particular view template will be code specific to that code.

- How?

in "layout.erb", we "<%= yield %>"

- How to invoke layout.erb

erb :list_all
or
erb :list_all, layout: :layout

Note how the yield keyword is used in a layout to indicate where the content
  from the view template will end up.

" TEMPLATE PARAMETERS "
- need to be defined as instance variables in routes.

################################### SESSIONS ###################################
# http://guides.rubyonrails.org/security.html#sessions

# http://sinatrarb.com/intro.html

# https://launchschool.com/books/http/read/statefulness#sessions

Q - What is a session?
A - its a way to keep state during requests. It does this by
    sending a cookie with session data to a clients web browser. This cookie
    is then included on future requests to the server as a way for the web app
    to verify the details of the data, and respond accordingly.
    We know HTTP is stateless, and therefore this allows a way to store data
      during one request for access in later requests.
    Common usage would be for tracking whether a user is logged in.

Q - Where is it stored?
A - Session data is stored on the server and accessible as a hash.

Q - How is it used?
A - Can be modified/accessed via Sinatra routes.

# Setup in our app
configure do                               # configure block is enabling these settings
  enable :sessions
  set :session_secret, 'secret'
end

############################### ROUTE PARAMETERS ###############################

Parameters added to the URL pattern.

ie: get "/chapters/:number" do end

This will match any route that starts with "/chapters/" followed by a single segment

Values passed to the app thru the URL in this way appear in the params Hash that
  is automatically made available in routes.

# Can access as follows:

get "/chapters/:number" do
  @chapter_number = params[:number] # method 1 (symbol)
  @chapter_number = params["number"] # method 2 (string)
end

# another example
get "/course/:course/instructor/:intructor" do |course, instructor|
  # option 1
  @course_id = params["course"]            # using params hash
  @instructor_id = params["instructor"]
  # option 2
  @course_id = params[:course]             # using params hash
  @instructor_id = params[:instructor]
  # option 3
  @course_id = course                      # This code obtains the parameters from the block parameters.
  @instructor_id = instructor
  erb :course_roster, layout: layout
end

################################## REDIRECTING #################################

1) # this one gets executed when it cant find a route
not_found do
  "That page was not found"
end

2)
redirect "/a/good/path"

 - WHAT HAPPENS WITHIN HTTP RESPONSE?
1) HTTP Response : sets "Location" header in HTTP response + status code value to range 3XX
2) Browser confirms status code as a redirect, looks at "Location" and makes a
    GET request to the provided URL

 - WHY IS IT NEEDED?

################################# SEARCH FORM #################################
# https://launchschool.com/lessons/ee756b04/assignments/09d7452c
So far parameters have been extracted from the URL.
There are two other ways to get data into the params hash:

1. Using query parameters in the URL
2. By submitting a form using a POST request

How it works?
- When a form is submitted, the browser makes a HTTP request.
- This request is made to the path or URL specified in the "action" attribute of the form element.
- The method attribute of the form determines if the request made will use GET or POST.
- The value of any input elements in the form will be sent as parameters.
  The keys of these parameters will be determined by the "name" attribute of the corresponding input element.

# HTML CODE
<h2 class="content-subhead">Search</h2>

<form action="/search" method="get">
  <input name="query" value="<%= params[:query] %>">
  <button type="submit">Search</button>
</form>

# Corresponding Ruby Code
get "/search" do
  @results = chapters_matching(params[:query])
  erb :search
end

Were using GET as the method for this form because performing a search doesnt modify any data.
  If our form submission was modifying data, we would use POST as the forms method.

################################ BEFORE FILTERS ################################

- things that need to be done on every requqest.
ie: checking if user is logged in


################################### HELPERS ####################################

- methods wrapped in helpers are available to be used in view templates
- also note, they dont need to be wrapped in "helpers do" to be accessible
helpers do
  def method_name
  end
end

############################### POTENTIAL ERRORS ################################
# https://launchschool.com/quizzes/70020696

1) erb code trying to evaluate a variable defined as a local variable in ruby app code
   and not as an instance variable.
Result -> error

get "/" do
  name = "Bob"                    # local var needs to be instance var @name
  @address = ["123 Oak Street", "Portland", "Oregon", "97232"]
  erb :index
end

<html>
  <p>Welcome <%= name %>!</p>
  <p>Your address is: <% @address.join(", ") %>.</p>
</html>
-------------------------------------------------------------------------------
2) wrong tag used to evaluate code "<% @some_var %>" vs "<%= @some_var %>"

Resulte -> so long as @some_var exists, it will be true but not return value









.
