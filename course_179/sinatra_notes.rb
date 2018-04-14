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

############################### ROUTE PARAMETERS ###############################

Parameters added to the URL pattern.

ie: get "/chapters/:number" do end

This will match any route that starts with "/chapters/" followed by a single segment

Values passed to the app thru the URL in this way appear in the params Hash that
  is automatically made available in routes.

# Can access as follows:

get "/chapters/:number" do
  @chapter_number = params[:number] # method 1
  @chapter_number = params["number"] # method 2
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

1)
not_found do
  "That page was not found"
end

2)
redirect "/a/good/path"

 - WHAT HAPPENS WITHIN HTTP RESPONSE?
1) HTTP Response Requires : sets "Location" header in HTTP response + status code value to range 3XX
2) Browser confirms status code, looks at "Location" and navigates to URL


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

1) erb code trying to evaluate a variable defined as a local variable in ruby app code.

Result -> error

get "/" do
  name = "Bob"
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
