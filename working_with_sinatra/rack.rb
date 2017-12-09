# Rack: Sinatra and Rails are compatible frameworks with Rack

- previous course touched on our own TCP server processing requests.
- more robust web server that comes with Ruby: WEBrick

- RACK; helps us connect and work with WEBrick
        Rack is a generic interface to help application developers connect to web
          servers, so it works with many other servers besides WEBrick.

# Illustrate where Rack and WEBrick fall inline

                                          request   response
                                            |         ^
                ---------------------       V         |
      ----------                           WEBrick
server                                        |
      ----------                           Rack App
                ---------------------
Were essentially replacing our TCP server with WEBrick and our Ruby code with a Rack application.
When working with Rack applications, our entire server is comprised of the Rack
  application and a web server (probably WEBrick, which comes with your Ruby installation).

Most developers wouldnt write Rack applications except for the simplest of
  situations, but we will show you how for instructional purposes.

############################# BLOG SERIES ON RACK ############################

################################### Part 1 ###################################
##############################################################################

This post is the first part in a four part series on how to build your own web framework with Rack.

- What is Rack?
Rack is a web server interface that provides a fluid API for creating web applications.
  You may know of several popular frameworks that are “rack based”, such as Sinatra or
  Ruby on Rails. We call those frameworks rack based because they adhere to the Rack
  interface to easily communicate between the server and the client.

No need to reinvent the wheel every time we need an interface to work with a server.
Rack gives developers a consistent interface when working with Rack compatible servers,
  effectively giving web server developers and application framework developers a common language.

# Setup

Step 1) created a new folder called "my_framework"
       windows poershell; new-item -Name my_framework -itemtype directory
       cd into this new folder
Step 2) create a new Gemfile
       Gemfile
       # Gemfile
       source "https://rubygems.org"
       gem 'rack', '~> 2.0.1'
       then run bundle install

# What Makes a Rack App

Rack; it’s a specification for connecting our application code to the web server,
  and also our application to the client. It sets and allow us to utilize a standardized
  methodology for communicating HTTP requests and responses between the client and
  the server. To accommodate this standard, Rack has some very specific conventions
  in place. Here is what you need to make your Ruby code into a Rack application:

1. Create a “rackup” file: this is a configuration file that specifies what to
                          run and how to run it. A rackup file uses the file extension .ru.
2. The rack application we use in the rackup file must be an Ruby object that
   responds to the method call(env). The call(env) method takes one argument, the environment variables for this application.

The call method always returns an array, containing these 3 elements [1]:
  1. Status Code: represented by a string or some other data type that responds to to_i.
  2. Headers: these will be in the form of key-value pairs inside a hash. The key will
              be a header name and the corresponding value will be the value for that header.
  3. Response Body: this object can be anything, as long as that object can respond
                    to an each method. An Enumerable object would work, as would a
                    StringIO object, or even a custom object with an each method
                    would work. The response should never just be a String by itself,
                    but it must yield a String value.
Together, these three elements represent the information that will be used to put
  together the response that is sent back to the client. If we have all of the above
  within our application directory, then we have the start of a Rack application.
  Let’s follow these instructions and get started on making a Rack application now.

# A Simple Rack Application - Hello World!

Step 1) “rackup” configuration file to run our application
        by default Rack will expect it to be called config.ru, though any file ending in .ru would work
        create + save file in our root directory
        # config.ru
        require_relative 'hello_world'

        run HelloWorld.new
Note: We have two things in our configuration file, a require_relative
      that loads a file called hello_world.rb, and a call to the run method.
      Rack configuration files use run to say what application we want to run on our server.
We created a HelloWorld class which will act as our web application and is where most
  of our application code will be.

  my_framework/
   ├── Gemfile
   ├── Gemfile.lock
   ├── config.ru
   └── hello_world.rb

hello_world.rb code;

# hello_world.rb

class HelloWorld
  def call(env)
    ['200', {'Content-Type' => 'text/plain'}, ['Hello World!']]
  end
end

We now have all the requirements for our Rack application.
 - We have a configuration file that tells the server what to run (the config.ru file).
 - We also have the application itself, the HelloWorld class in the hello_world.rb file.
 - We know it is a Rack application because it has the method call(env), and that
    method returns a 3 element array containing the exact information needed for a proper Rack application:
    a status code (string), headers (hash), and a response body (responds to each).

To start a Rack application, we’ll use the rackup command; make sure to
  prepend the command bundle exec when starting up the server in your terminal.
  The command you use to start our web application should look like:

# to start our Rack application
$ bundle exec rackup config.ru -p 9595

The -p flag allows us to specify which port we want our application to run on.
  We chose 9595 here, but it could be any other valid number.
  It will accept any valid port number between 0 and 65535.
  If you don’t specify a port number the application server will default to 9292 with rackup

# ping the server to see the response
We should get back a status of 200 and a response body that says “Hello World!”.
Make sure that you use a separate terminal tab or window to ping the server.

=begin
Note: 1. I opened a new powershell window and ran a different line of code
      2. from bundle exec rackup... above, it's essentially launching our server
         and in the new powershell window we are accessing its contents.
      3. with server still running, we can also check out the page in our browser
=end
# Launch School version:
$ curl -X GET localhost:9595 -m 30 -v
# My way of getting it to run:
curl http://localhost:9595
# In browser
http://localhost:9595/

Note that Rack doesn’t come with its own server, but it’s smart enough to
  automatically try to use a sever that’s already installed on your machine.
  If you didn’t install any server, like Puma or Thin, then Rack will just use
  the default server that comes with Ruby, Webrick.


  ################################### Part 2 ###################################
  ##############################################################################


































.
