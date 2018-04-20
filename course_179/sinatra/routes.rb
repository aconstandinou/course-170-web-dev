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
