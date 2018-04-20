################################################################################
##################################### RACK #####################################
################################################################################

# PART I - Rack Basics

- Rack library: generic interface to help app developers connect to web servers (ie: WEBrick, Puma)
- Rack is also be used to build simple web apps (like Sinatra or Rails)

Server as a whole includes 1) rack app & 2) web server.

Rack = specification for connecting our app code to the web server, and also our app to the client.
       sets and allow us to utilize a standardized methodology for communicating HTTP requests
         and responses between the client and the server.

Requirements
1. rackup file = config.ru (specifies what to run and how to run it)
2. rack app in .ru must be a Ruby Object that responds to method #call(env)
  call(env) method takes one argument, the environment hash variable for this app.

The call method always returns an array, containing these 3 elements:

  1. Status Code: represented by a string or other data type that responds to #to_i
  2. Response Headers: these will be in the form of key-value pairs inside a hash.
              The key will be a header name and the corresponding value will be the value for that header.
  3. Response Body: this object can be anything, as long as that object can respond to an #each method.
                    An Enumerable object would work, as would a StringIO object, or
                    even a custom object with an each method would work.
                    The response should never just be a String by itself, but it must yield a String value.

# ------------------------ code ---------------------------
# config.ru file
require_relative 'hello_world'
run HelloWorld.new
# --------------------- end of code -----------------------

Two things in config.ru: 1. require_relative that loads our app called hello_world.rb
                         2. a call to the run method. Rack configuration files
                            use run to say what application we want to run on our server.

# ------------------------ code ---------------------------
# hello_world.rb file
class HelloWorld
  def call(env)
    ['200', {'Content-Type' => 'text/plain'}, ['Hello World!']]
  end
end
# --------------------- end of code -----------------------

to start rack app -> $ bundle exec rackup config.ru -p 9595
in browser -> http://localhost:9595/

# PART II - How Rack keeps track of request data -> via headers
# https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-2

in call method, env argument -> - contains all environment variables and info related to HTTP request
                                    for hello_world.rb app
                                - contains info for headers + specific infor about Rack.

Dynamic Content -> help from routing (aka routes)

# PART III - View Templates/ERB
# https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-3

View Template : separate files that allow us to do some pre-processing on server side in
                Ruby (could also be Python, JS, etc) and translate code into a string
                to return to client (usually HTML)
                **removes the need to write HTML directly inside the string we return**

ERB : a view templating library, "Embedded" Ruby.
      allows us to embed Ruby directly into HTML
To use ERB, first we must:
  1. require 'erb'
  2. Create an ERB template object and pass in a string using the special syntax that mixes Ruby with HTML.
  3. Invoke the ERB instance method result, which will give us a 100% HTML string.

example in irb -> require 'erb'
  def random_number
    (0..9).to_a.sample
  end
  content1 = ERB.new("<html><body><p>The number is: <%= random_number %>!</p></body></html>")
  content1.result
  => "<html><body><p>The number is: 7!</p></body></html>"

"<%= %>" – will evaluate the ERB code, and include its return value in the HTML output.
            A method invocation, for example, would be a good candidate for this tag.
"<% %>" – will only evaluate the Ruby code, but not include the return value
            in the HTML output.
          Use: to evaluate Ruby but not include its return value in the final string.
               A method definition, for example, would be a good use case for this tag.

# Adding View Templates
1. Create a views directory
2. default file should be named #views/index.erb

# PART IV - Conclusion
# https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-4


################################################################################
################################## FOUNDATION ##################################
################################################################################
https://launchschool.com/lessons/2fdb1ef0/assignments/1752fa44

# Gemfile - 4 key pieces of info
1. Where should Bundler look for Rubygems it needs to install?
#  source 'https://rubygems.org'
2. Do you need a .gemspec file?
3. What version of Ruby does your program need? (Recommended, not required)
#  ruby "2.3.3"
4. What Rubygems does your program use?
# gem "sinatra"
# gem "minitest"
# gem "rack", "~> 1.5"

# Running Bundler
bundle install -> generates Gemfile.lock file that contains all the dependency information for your app
