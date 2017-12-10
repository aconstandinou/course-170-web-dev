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
       windows powershell command = $ new-item -Name my_framework -itemtype directory
       cd into this new folder
Step 2) create a new Gemfile
       Gemfile code
       # Gemfile
       source "https://rubygems.org"
       gem 'rack', '~> 2.0.1'
       then run -> $ bundle install

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

The call method always returns an array, containing these 3 elements []:
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
        config.ru code;
        # config.ru
        require_relative 'hello_world'

        run HelloWorld.new

Note: We have two things in our configuration file, a require_relative
      that loads a file called hello_world.rb (later changed to app.rb), and a
      call to the run method. Rack configuration files use run to say what
      application we want to run on our server.
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
  automatically try to use a server that’s already installed on your machine.
  If you didn’t install any server, like Puma or Thin, then Rack will just use
  the default server that comes with Ruby -> Webrick.


################################### Part 2 ###################################
##############################################################################

there is one other component of the call method that we have been ignoring, the
  "env" argument. What is the point of env, and why might we need it.


# Routing: Adding in other pages to our app

We have an application that delivers a simple message, “Hello World!”,
  to the client no matter what type of request or query parameters are sent.
  But what if we want a bit more functionality in our application?
  We may want to send a dynamic string back to the client based on the request.

Let’s create another file to act as the storage for our dynamic content.
  We’ll pretend that our web application is going to send back some piece of advice,
  so we’ll create an Advice class in an advice.rb file

my_framework/
 ├── Gemfile
 ├── Gemfile.lock
 ├── config.ru
 ├── hello_world.rb
 └── advice.rb

 # advice.rb

 class Advice
   def initialize
     @advice_list = [
       "Look deep into nature, and then you will understand everything better.",
       "I have found the paradox, that if you love until it hurts, there can be no more hurt, only more love.",
       "What we think, we become.",
       "Love all, trust a few, do wrong to none.",
       "Oh, my friend, it's not what they take away from you that counts. It's what you do with what you have left.",
       "Lost time is never found again.",
       "Nothing will work unless you do."
     ]
   end

   def generate
     @advice_list.sample
   end
 end

NOTE: 1) notice that the class above is not a separate web app like HelloWorld.
         it doesnt have a call method. Class is solely used for content generation.
      2) With Advice class, we only want to augment our web app.

Answer: "Routing": allows us to use HTTP request to decide which URL to navigate to.

How? - if request path specifies root path (just '/') show "Hello World" message
       if request path specifies '/advice' then well reply with random advice.
       we will also add in one more route to handle any pages that dont exist within app.

we modified our hello_world.rb code

require_relative 'advice'     # loads advice.rb

class HelloWorld
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      ['200', {"Content-Type" => 'text/plain'}, ["Hello World!"]]
    when '/advice'
      piece_of_advice = Advice.new.generate    # random piece of advice
      ['200', {"Content-Type" => 'text/plain'}, [piece_of_advice]]
    else
      [
        '404',
        {"Content-Type" => 'text/plain', "Content-Length" => '13'},
        ["404 Not Found"]
      ]
    end
  end
end


restart server
$ bundle exec rackup config.ru -p 9595

# outputs from browser
Root Path (localhost:9595/)
"Hello World!"

Advice Path (localhost:9595/advice)
random advice is generated

Missing Path (localhost:9595/whatever)
"404 Not Found"

# Adding HTML to Response Body

Goals:
  1. Make "Hello World" an "h2" header.
  2. Italicize and bold our advice.
  3. For 404 page, make it an "h4"
     NOTE: dont forget to change the content-type of our HelloWorld.
           If we keep it as "text/plain" we will show our actual HTML to the client.
           We want the client to actually render the HTML.

New Code changed to

require_relative 'advice'

class HelloWorld
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      [
        '200',
        {"Content-Type" => 'text/html'},
        ["<h2>Hello World!</h2>"]
      ]
    when '/advice'
      piece_of_advice = Advice.new.generate
      [
        '200',
        {"Content-Type" => 'text/html'},
        ["<html><body><b><em>#{piece_of_advice}</em></b></body></html>"]
      ]
    else
      [
        '404',
        {"Content-Type" => 'text/html', "Content-Length" => '48'},
        ["<html><body><h4>404 Not Found</h4></body></html>"]
      ]
    end
  end
end

Note that if we didn’t update the content type of our response then we would see
     actual html code and not the output we want. Ex:

# Root Path (localhost:9595/)
<h2>Hello World!</h2>

Some things to point out;

There are still some improvements that can be made. We’re writing the same
  code over and over again in those response bodies. HTML tags and body tags
  are listed in each of the three cases above. We want to avoid repetition.

One other issue is that our HTML responses are hardcoded in the routing code,
  essentially very restrictive. As an application grows and changes, it may
  be necessary to return responses that are far more complex than what we
  currently have. Imagine trying to include all the HTML necessary for the
  front page of your favorite web application into the code we have. It would
  take up far too much space and make our call method unmanageable.

################################### Part 3 ###################################
##############################################################################

# View Templates

view templates = pieces of code we can store and maintain related to what we want to display.

View templates are separate files that allows us to do some pre-processing on
  the server side in a programming language (Ruby, Python, JavaScript, etc) and
  then translate programming code into a string to return to the client (usually HTML)

# ERB

"Embedded Ruby" (ERB) = template engine that allows us to embed Ruby directly into HTML.
                        it produces a final 100% HTML string.

Can test ERB engine in irb.

To use ERB, first we must:

- require 'erb'
- Create an ERB template object and pass in a string using the special syntax that mixes Ruby with HTML.
- Invoke the ERB instance method result, which will give us a 100% HTML string.

in irb

require 'ERB'

def random_number
  (0..9).to_a.sample
end

content1 = ERB.new("<html><body><p>The number is: <%= random_number %>!</p></body></html>")
content2 = ERB.new("<html><body><p>The number is: <%= random_number %>!</p></body></html>")
content1.result
=> "<html><body><p>The number is: 7!</p></body></html>"
content2.result
=> "<html><body><p>The number is: 8!</p></body></html>"

Note that we’re instantiating a new ERB template object with Ruby and HTML mixed together.
Note also that we’re using the "<%= %>" special syntax to let ERB know how to process this mixed content.

The final output from ERB is pure HTML.

"<%= %>": ERB tags used to execute Ruby code that is embedded within a string

Two tags:
'<%= %>' – will evaluate the embedded Ruby code, and include its return value in the HTML output.
           A method invocation, for example, would be a good candidate for this tag.
'<% %>' – will only evaluate the Ruby code, but not include the return value in the HTML output.
          You’d use this tag for evaluating Ruby but don’t want to include its return value in
          the final string. A method definition, for example, would be a good use case for this tag.


# Adding in View Templates

default view template -> index.erb

Step 1) Created a folder called 'views'
        Created a file in that folder called index.erb
        index.erb code:

        <html>
          <body>
            <h2>Hello World!</h2>
          </body>
        </html>

We want some organization within our application, so for now, we’ll put all
  view templates in the views folder. This folder should be located at the
  top-level of our application (root), along with config.ru and hello_world.rb

Application now looks like this
my_framework/
 ├── Gemfile
 ├── Gemfile.lock
 ├── config.ru
 ├── hello_world.rb
 ├── advice.rb
 └── views/
       └── index.erb

new code
# hello_world.rb

class HelloWorld
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      template = File.read("views/index.erb")
      content = ERB.new(template)
      ['200', {"Content-Type" => "text/html"}, [content.result]]
    when '/advice'
      piece_of_advice = Advice.new.generate
      [
        '200',
        {"Content-Type" => 'text/html'},
        ["<html><body><b><em>#{piece_of_advice}</em></b></body></html>"]
      ]
    else
      [
        '404',
        {"Content-Type" => 'text/html', "Content-Length" => '48'},
        ["<html><body><h4>404 Not Found</h4></body></html>"]
      ]
    end
  end
end

- with view template, we can read it into our application and use it.
  We used ".read" method from Ruby "File" class

- now we have view template in string format, we can pass it into ERB object
  and use that as a way to get our response body.

- weve fixed one of our three routes and the other two still have HTML within their
  routing code (which we will change).

################################### Part 4 ###################################
##############################################################################

Focus
  1 - Continue to separate out the view related code for our other routes
  2 - Extract some more general purpose methods to a framework.

# cleaning up #call method

- reviewing our call method in "hello_world.rb"
  we have code related to reading in files and setting up a templating object,
  an object not directly related to the request or response.
- clean-up; move code to its own method, then use method within call method.

This is what we want to accomplish using a non-existent erb method that abstracts away
  the details of how ERB templates are prepared and rendered. We pass that erb
  method a symbol, signifying which template to render

# hello_world.rb

def call(env)
  case env['REQUEST_PATH']
  when '/'
    ['200', {"Content-Type" => "text/html"}, [erb(:index)]] # ***RIGHT HERE!***
  when '/advice'
    piece_of_advice = Advice.new.generate
    [
      '200',
      {"Content-Type" => 'text/html'},
      ["<html><body><b><em>#{piece_of_advice}</em></b></body></html>"]
    ]
  else
    [
      '404',
      {"Content-Type" => 'text/html', "Content-Length" => '48'},
      ["<html><body><h4>404 Not Found</h4></body></html>"]
    ]
  end
end

# here is the erb implementation
def erb(filename)
  path = File.expand_path("../views/#{filename}.erb", __FILE__)
  content = File.read(path)
  ERB.new(content).result # this returns our ERB object with HTML rendered
end

- note the method "File::expand_path"
  We’re using this method to obtain the full path to the view template in question.
  __FILE__ returns the relative path to the current file; in this case, to the file hello_world.rb
  From there we navigate up to my_framework and then append /views/#{filename}.erb

- Using that helpful erb method results in much cleaner code, and leaves our
  call method very intentional and clear.


# Adding More View Templates

- we need a view template for both “advice” and “not found” pages.
Step 1) create advice.erb file within views folder
        code
        <html>
          <body>
            <p><em><%= message %></em></p>
          </body>
        </html>
# message above will be the sample string extracted from Advice

Step 2) create not_found.erb file within views folder
        code
        <html>
          <body>
            <h2>404 Not Found</h2>
          </body>
        </html>

File structure

my_framework/
 ├── Gemfile
 ├── Gemfile.lock
 ├── config.ru
 ├── hello_world.rb
 ├── advice.rb
 └── views/
        ├── index.erb
        ├── advice.erb
        └── not_found.erb

# we now want to refactor our erb within Hello_World.rb
def erb(filename, local = {})
  b = binding
  message = local[:message]
  path = File.expand_path("../views/#{filename}.erb", __FILE__)
  content = File.read(path)
  ERB.new(content).result(b)
end

first line in the method, b = binding is necessary.
The next line takes the value from our passed in hash and assigns it to a variable.
The key we’re expecting is called :message, and if that key doesn’t exist, then the
  message variable is nil.
The message local variable is then made available within our ERB template when
  we pass in the binding, b, to our ERB template object on the last line.
Again, if you’re unsure how binding works, just know that the message local
  variable is made available to the view templates when local[:message] is not nil.

# Refactoring and Streamlining our Application

- weve renamed our hello_world.rb file to app.rb since its more dynamic.
  we also updated config.ru file for this change.

- next optimization; update how we compose our response.
  See how we have to use the result of the erb method within an array literal?
  We also have to manually list out the status code, headers, and the response
  body. It would be nice if we could use a more natural syntax for delivering
  a response from our call method.

def call(env)
  case env['REQUEST_PATH']
  when '/'
    status = '200'
    headers = {"Content-Type" => 'text/html'}
    response(status, headers) do
      erb :index
    end
  when '/advice'
    piece_of_advice = Advice.new.generate
    status = '200'
    headers = {"Content-Type" => 'text/html'}
    response(status, headers) do
      erb :advice, message: piece_of_advice
    end
  else
    status = '404'
    headers = {"Content-Type" => 'text/html', "Content-Length" => '61'}
    response(status, headers) do
      erb :not_found
    end
  end
end

- looks nicer and we dont have to insert an Array literal into our call method.
- now we need a new method "response"
  def response(status, headers, body = '')
    body = yield if block_given?
    [status, headers, [body]]                   # needed as our return and removed from call method above
  end

Seems simple enough, if we do want to use a view template, then we pass it in
  as a block of code to our response method. Otherwise, we allow the user to
  specify the response value as a third method argument
The creation and organization of the response itself is encapsulated within
  this method as well, pushing the unsightly nested array syntax to this
  private method. This means we can use a much more natural syntax in our call
  method, which is where we’ll be writing most of our application logic code.
  Consolidating the core processing of the response into this response method
  also gives us one place to update should we have new requirements in the future.

# Start of a Framework





























.
