#################################### HTTP #####################################

###############################################################################
# Describe what HTTP is and the role of the request and the response.
###############################################################################
- HTTP -> Hypertext Transfer Protocol
- HTTP is an application layer protocol, a system of rules that serve as a link between applications
  and the transfer of hypertext documents.

- Request response cycle is one of the basic methods computers use to communicate with each other.

Example: clients browser wants to view a web page, hence why our URLs start with http://
- The model allows the client to make requests to a server, and await a response.
  This is known as the request response protocol.
- HTTP is stateless, where each pair of request/response are independent of the previous one.
Example: servers dont need to hang on to information or state between requests.

###############################################################################
# What are the components of an HTTP request and an HTTP response?
###############################################################################

HTTP Request - A request is sent to a host and must include a method, path and host header.
# (required)
- HTTP Method (verb that tells server what action to perform on resource)
          Most common: GET and POST
- path : /tasks
- host header : www.reddit.com
# (optional)
- parameters : ?due=today
- headers : additional info during request/response cycle.
              colon-separated name-value pairs sent in plain text.
              examples:
              Accept-Language--List of acceptable langs----------Accept-Language: en-US..
              User-Agent-------String that identifies client-----User-Agent: Mozilla/5.0
              Connection-------Type of connection client prefers-Connection:keep-alive
- message body (for POST requests):
           to send or submit data to server (initiates some action)

HTTP Response
(required)
- Status Code: 3 digit number that server sends back after receiving request.
              ie: 200 OK, 302 Found, 404 Not Found, 500 Internal Server Error
(optional)
- Headers: offers info on resource being sent back.
              ie: Content-Encoding, Server, Location, Content-Type
- Message Body: contains the raw response data


# NOTE - What are headers? (Both Requests and Responses)
HTTP headers are name-value pairs included in a HTTP request or response.
Headers act as metadata that provides supplemental information about the
request/response to aide the server or client in processing the request or response.

OSI -> https://launchschool.com/lessons/1ba34626/assignments/f2948005

###############################################################################
# Identify the components of a URL. Construct a URL that contains a few params and values.
###############################################################################

http://www.example.com:88/home?item=book
{ 1 } {       2       }{3}{ 4 }{   5   }

# {1} PROTOCOL: http (always comes before colon and 2 forward slahes)
#             tells web client how to access the resource.
#             examples: http, https, ftp, mailto, git
# {2} HOST: www.example.com
#           tells client where the resource is hosted or located.
# {3} PORT :88
#          only required if you want to use a port other than default
# {4} PATH /home
#          shows local resource is being requested. (OPTIONAL)
# {5} QUERY PARAMETERS/
#     QUERY STRING      :    ?item=book
#                            sends data to server. (OPTIONAL)

# Default Ports (encrypted and unencrypted data)
# HTTPS vs HTTP
HTTP default port 80 for unencrypted data transmission; HTTPS default port 443 for encrypted data transmission.
Even though this port number is not always specified, its assumed to be part of every URL.
Must specify port in URL if different from http 80 || https 443

# URL Construction:
http://www.phoneshop.com?product=iphone&size=32gb&color=white
name-value pairs = product=iphone, size=32gb, color=white
"?" reserved character that marks the start of the query string
"&" reserved character, used when adding more parameters to the query string.
"%20" or "+" replace spaces " " in search queries

###############################################################################
# Explain the difference between GET and POST, and know when to choose each.
###############################################################################
GET requests should only retrieve content from the server. They can generally
  be thought of as "read only" operations, although there are some subtle
  exceptions to this rule. For example, consider a webpage that tracks how many
  times it is viewed. GET is still appropriate since the main content of the
  page doesnt change.

POST requests involve changing values that are stored on the server. Most HTML
  forms that submit their values to the server will use POST. Search forms are
  a noticeable exception to this rule, and they often use GET since they are not
  changing any data on the server, only viewing it.

# When to use POST?
"destructive" actions: creation, editing, and deletion

"GET vs POST (security)":
Any request sent as plain text, regardless of the HTTP method used, is
  equally vulnerable to being seen while in transit on the network.

###############################################################################
# What is the difference between client-side and server-side code?
# For each file in a Sinatra project, be able to say which it is.
###############################################################################
  client side code are programs that run on the client and includes the user
    interface with which the user interacts, whereas server side code are
    programs run on the server and interact with the back end.

"Server Side"
Gemfile: File used by bundler - Ruby dependency management system to install
         libraries needed to run the program.
Ruby files (.rb): Core of a Sinatra App. Code runs on server while handling
                  incoming requests.
View Templates (.erb): evaluated on the server to generate a response that will then be sent to the client.
                              server side because they have to be parsed by the server.
                              Until they are done being parsed and rendered,
                              the response is not sent back.
"Client Side"
Stylesheets (.css): files are interpreted by web browser (client) as instructions
                    for how to display a web page.
JavaScript Files (.js): evaluated by the JavaScript interpreter within a web
                        browser (a client) to add behavior to a web page.

###############################################################################
############################## INSPECTOR TOOL ################################
###############################################################################

- It lets you view HTTP requests made to the current web domain.
- It lets you view HTTP responses returned by the current web domain.
- It lets you view the HTML, CSS, and Javascript for the current web page.

###############################################################################
########################### SIMULATE "STATEFUL" APP ###########################
###############################################################################
https://launchschool.com/books/http/read/statefulness

1. By sending data as parameters through the URL.
2. Using Cookies: Cookies are temporary pieces of information that we can send
                  back and forth via the HTTP requests and responses
3. Using Sessions: data to keep track of a user for a given web domain.

Sessions: server sends unique token to the client. Client making a request to the server,
            client appends token as part of the request, then server can identify client.
          (stored on server)
          1. Every request must be inspected to see if it contains a session identifier.
          2. If it does contain a session id, server must check if that this session id is still valid.

Cookies: are small files stored in the browser and contain the session information.
         Note that the actual session data is stored on the server. The client
           side cookie is compared with the server-side session data on each request
           to identify the current session.

Bringing it altogether. Logged into LS, and opened inspector tool.
    Under Application -> under Cookies -> clicked on https://launchschool.com
    We can identify _railstutors_session -> our session
    We can identify uuuid -> our cookie

    With the session id now being sent with every request, the server can now
      uniquely identify this client. When the server receives a request with a
      session id, the server will look for the associated data based on that id,
      and in that associated session data is where the server "remembers" the
      state for that client, or more precisely, for that session id.
###############################################################################
############################# SAME ORIGIN POLICY ##############################
###############################################################################
Must have:
1. same host name (ie: www.google.com)
2. same port (ie: 80)
3. same protocol (ie: http or https)

###############################################################################
######################### SERVER SIDE INFRASTRUCTURE ##########################
###############################################################################

- 3 main pieces: data store, application server, web server.
A web server to serve static assets, HTML, CSS, and Javascript to the client.
An application server that contains application logic and handles most HTTP
  requests from the client.
A data store that the application server interacts with to persist information
  about the application, and to retrieve that information when necessary.
