################################### SINATRA ####################################

Rack-based implies : - uses Rack to connect to a web server, like WEBrick.

Sinatra
- A Rack-based web development framework
- A productivity tool that helps speed development by automating routine tasks like
    redirection, control flow, and display of dynamic data
- A domain-specific language (DSL) that lets developers use Ruby to create web applications

At the core, its Ruby code connecting to a TCP server, handling requests and
  sending back responses all in an HTTP-compliant string format.

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

Result -> so long as @some_var exists, it will be true but not return value
