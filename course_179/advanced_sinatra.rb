############################### ADDITIONAL NOTES ###############################

- These notes are meant to highlight some questions that came up. Specifically,
  when working with Rack and jumping into Sinatra, it wasnt totally clear how Sinatra,
  a rack-based library, would replicate elements learnt in Rack. Here are some ex:

In Sinatra:

get "/" do
  "sent via http"
end

In Rack:

class HelloWorld
  def call(env)
    ['200', {'Content-Type' => 'text/plain'}, ['Hello World!']]
  end
end

############################ Return Values of Routes ############################
# http://sinatrarb.com/intro.html       ctrl+f for Return Values

#  assume index.erb contains HTML + ruby code

get "/" do
  erb :index
end

1) Return value sets Response Body
2) Can return any object that would either be a valid Rack response,
   Rack body object or HTTP status code:
   - An Array with three elements: [status (Fixnum), headers (Hash), response body (responds to #each)]
   - An Array with two elements: [status (Fixnum), response body (responds to #each)]
   - An object that responds to #each and passes nothing but strings to the given block
   - A Fixnum representing the status code

Calling erb method on :index -> - reads view template specified.
                                - returns string that can be used in response body.

################################### Call to env ################################

The necessary invocation to call and a Rack response object is used under the
  hood to make all of this happen whenever a request is made
