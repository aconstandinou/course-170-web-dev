##################### WHAT IS A URL #####################

http://www.example.com:88/home?item=book

- http: scheme. Always comes before colon and two forward slashes.
      Tells web how to access resource.

- www.example.com: host. tells the client where the resource is hosted.

- 88: port number. Only required to use a port other than default.

- /home/: the path. Shows what local resource is being requested. Considered to be optional.

- ?item=book: query string made up of query parameters.

##################### Query Strings/Parameters #####################

Ex: http://www.example.com?search=ruby&results=10

Query Component   Description
?                 Reserved character that marks start of string.
search=ruby       A parameter name/value pair.
&                 Reserved character thats used when adding more than one parameter.
results=10        A parameter name/value pair.

###################### URL Encoding #####################

- designed to only accept certain characters in the ASCII character set.
- unsafe or reserved chars are not included in the set and have to be converted or "encoded"
  to conform to this format.

Character  ASCII Code  URL
Space      20          http://www.thedesignshop.com/shops/tommy%20hilfiger.html
!          21          http://www.thedesignshop.com/moredesigns%21.html
+          2B          http://www.thedesignshop.com/shops/spencer%2B.html
#          23           http://www.thedesignshop.com/%23somequotes%23.html

Examples:

# characters must be encoded if:
1. They have no corresponding character within the ASCII character set.
2. The use of the character is unsafe. For example % is unsafe because it is used
   for encoding other characters.
3. The character is reserved for special use within the URL scheme. Some characters
   are reserved for a special meaning; their presence in a URL serve a specific purpose.
   Characters such as /, ? :, @ and & are all reserved and must be encoded.

# what characters can be used safely?
# list:     $ - _ . + ! ' ( ) " ,

_______________________________________________________________________________

# HTTP
raw responses: http tool can show us the raw response.
browser receives all the data, and parses/processes it into a user-friendly format.

# Inspector
Chrome Browser -> More Tools -> Developer Tools

- Our example: https://www.reddit.com
- Use Inspector.
- Under Sources Tab, click www.reddit.com and then go to Network Tab.
---> Sub-Tab Headers: shows us request headers sent to the server as well as
                      response headers received back from server.

Note: all of the other responses. Who initiated these requests? In our initial
      www.reddit.com entry, returned some HTML. That HTML body has references
      to other resources like images, css stylesheets, javascript files and more.

# Status/Method Columns
- Method Column: HTTP request method. Typical ones are "GET" and "POST"
- Status Column: shows us response for each request. Various kinds exist.

When we type in a url into our browser, we are making a "GET" request.

# GET REQUESTS

- you make a GET request every time you type in a url into your browser and request the page.
- response from GET request can be anything, but if its HTML and that HTML references
  other resources, your browser will automatically request them.

# POST REQUESTS

- ie: submit user data to server, like a username and password.

note: you could try and send credentials over a URL (GET Request) but then that Data
      is available from within the url.

But how is our data being transmitted back to the server if its not in the URL.

# HTTP Body

The body contains data that is being transmitted in an HTTP message and is optional.

# HTTP Response headers

- allow the client and the server to send additional info during request/response
  HTTP cycle.

- using Inspector, and looking at the Header Tab with this url:
http://al-blackjack.herokuapp.com/new_player

we can see the various headers (Response and Request)

# Request Headers

Field Name   Description                            Example
Host         domain name of server.                 Host: al-blackjack.herokuapp.com
Accept-      List of acceptable languages.          Accept-Language: en-US,en;q=0.9
 Language
User-Agent   a string that identifies the client.   User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36
Connection   Type of connection the client prefers  Connection:keep-alive

# Summary

- should be able to:
  a) using the inspector to view HTTP requests
  b) making GET/POST requests with an HTTP tool

The most important components to understand about an HTTP request are:

- HTTP method
- path
- headers
- message body (for POST requests)


###############################################################################
######################## CHAPTER: PROCESSING RESPONSES ########################
###############################################################################

- raw data returned by server = "response"

# Status Codes

- status code: three digit number the server sends back after receiving a request.
- status text: displayed next to status code provides description of the code.

Status Code   Status Text               Meaning
200           OK                        Request was handled successfully.
302           Found                     Requested resource has changed temporarily.
                                        Usually results in a redirect.
404           Not Found                 Requested resource cannot be found.
500           Internal Server Error     Server has encountered a generic error.


# 302 Redirect

- resource is moved, common strategy to redirect original url to new url.
- browser automatically follows re-route in the "Location" response header.

ex: https://github.com/settings/profile
note: this link only works if youre already signed in. If not, it will redirect you.
      after re-route, you login and then re-routed once more back to original URL.

In our book example, using Postman we see status code 302 with the following...
In header, line "Location" has the following link
  https://github.com/login?return_to=https%3A%2F%2Fgithub.com%2Fsettings%2Fprofile

Notice the return_to parameter.


# 404 Not Found

our example uses link: https://www.dropbox.com/awesome_file.jpg


# 500 Internal Server Error


code says "there's something wrong on the server side". This is a generic
  error status code and the core problem can range from a mis-configured server
  setting to a misplaced comma in the application code. But whatever the problem,
  its a server side issue.


# Response Headers

Back to URL: al-blackjack.herokuapp.com/new_player
using Inspector -> Network Tab

Header Name       Description	                            Example
Content-Encoding	The type of encoding used on the data.	Content-Encoding: gzip
Server	          Name of the server.	                    Server:thin 1.5.0 codename Knife
Location	        Notify client of new resource location.	Location: https://www.github.com/login
Content-Type	    The type of data the response contains.	Content-Type:text/html; charset=UTF-8

###############################################################################
############################## STATEFUL WEB APPS ##############################
###############################################################################

- recall that HTTP protocol is stateless. This is, that each request is not dependent
    on the last. Server does not hang on to info between each request/response cycle.

- this statelesness = internet so distributed and difficult to control

- how can we maintain a state while using the web? ie: stay logged in to a website as we browse?
    -> Sessions
    -> Cookies
    -> Asynchronous JavaScript calls or AJAX

# SESSIONS

- server side identifier (unique) which is appended upon each request.
  -> this allows server to identify clients.
  -> unique token is known as "session identifier".
  -> each session is still considered stateless but the session id is passed.

- consequences :
  1. every request must be inspected to see if it contains the session id.
  2. if so, server must check to ensure it is still valid.
     server has rules on how to handle session expirations and how to store session data.
  3. server needs to retrieve session data based on session id.
  4. server needs to recreate the application state (ie: HTML for web request)
     from the session data and send it back as the response.

  server ends up working very hard for each request, and every request still gets its own
    response even if most of the response is identical to the previous response.

Example: logged into Facebook. On initial page, there is a lot happening as in pictures,
         likes, comments, etc. If you click on "like", Facebook needs to regenerate the
         entire page. Increments the number of "like"s and sends that HTML back as the response.
         NOTE: Facebook does use AJAX...

# Cookies

- piece of data sent from server and stored in the client during request/response cycle.
- small files stored in browser and contain session info.
- access website first time -> server sends session info -> cookie set in browser on local pc

Ex using Inspector: https://www.yahoo.com

Look at Request Header -> has no reference to cookies
Look at Response Header -> it has a "set-cookie" header
  on Chrome, looked like this
  "set-cookie:autorf=deleted; expires=Thu, 01-Jan-1970 00:00:01 GMT; Max-Age=0; path=/; domain=www.yahoo.com"
  This cookie data got set on the first visit to the website

After reloading the web page, look at Request Header ->
  cookie header now set (note the request header, implies its being sent by your client to the server).
  It contains the cookie data sent previously by the set-cookie response header.
  This piece of data will be sent to the server each time you make a request and
  uniquely identifies you or more precisely, it identifies your client, which is your browser.

# AJAX

short for Asynchronous JavaScript and XML

Main feature: allows browsers to issue requests and process responses without a full page refresh.
Example: logged into Facebook. Server has to generate initial page you see, and the response
         is a pretty complex and expensive HTML page that your browser displays.
         The Facebook server has to add up all the likes and comments for every
         photo and status, and present it in a timeline for you. Its a very expensive
         page to re-generate for every request (remember, every action you take
        clicking a link, submitting a form -- issues a new request).

When AJAX is used, all requests sent from the client are performed asynchronously,
  which just means that the page doesnt refresh.

Example: make a request to https://www.google.com and open Inspector
         On the Network tab and once you start typing in the Google search bar,
         you see the Network tab get flooded with many requests

        In a sense, the page isnt being refreshed. Every new letter typed is a new request,
        which means that an AJAX request is trigerred with every key-press.
        Responses provide some callback, which is a piece of logic you pass on to some
        function to be executed after a certain event. Callback is triggered when the response
        is returned. Callback is processing these requests and responses and therefore
        updating the HTML.

###############################################################################
################################### SECURITY ##################################
###############################################################################

Questions may arise in regards to session IDs and cookies. Can people steal
  that info? Access my sessions IDs, etc?

# Secure HTTPS

as client and server send requests and responses to each other, all info in both
  requests and responses are sent as "strings".

Packet Sniffing: employed by hackers to read the request/response messages
                 with the data, they could request from the server and pose as your client.

Secured HTTP = HTTPS

resource accessed via HTTPS begins with protocol https://

With HTTPS every request/response is encrypted before being transported on the network.

# TLS
TLS = HTTPS sends messages through cryptographic protocol
SSL = earlier version of TLS

# Same-origin policy & CORS

- a concept that permits resources originating from the same site to access each
  other with no restrictions but prevents access to docs/resources on diff sites.

- must have: same origin = same protocol, hostname and port number.

Ex 1: http://www.test.com/aboutus.html can embed contents of JS file at
      http://www.test.com/fancy.js

Ex 2: http://www.test.com cannot embed docs hosted on http://www.example.com

NOTE: same-origin policy pertains to accessing contents of files, and not linking.
       You are always free to link to any URL.

- this is quite cumbersome for developers, hence CORS was developed.

- "CORS": cross-origin resouce sharing
          mechanism that allows resources from one domain to be requested from another
          by-passing same-origin.
          CORS works by adding new HTTP headers, which allow servers to serve
          resources to permitted origin domains.

# Session hijacking

Recall, the session id is implemented as a random string and comes in the form of a cookie stored on the computer.
  When a users username and password match, the session id is stored on their browser
  so that on the next request they wont have to re-authenticate.

Countermeasures to session hijacking;

  - resetting sessions: this means a successful login must render an old session
                        id invalid and create a new one.
  - set expiration: ex: setting session to expire after 30 mins
  - use HTTPS across entire app

# Cross-Site Scripting (XSS)

- type of attack when you allow users to input HTML or JS that is displayed by site.
Ex: leaving a comment on a website via a Comment Box.

- one could add raw HTML and JS into the text area and submit it to the server.
- if server doesnt sanitize the input, user input will be injected into the page contents.
  browser will then interpet the HTML and JS and execute it.

ex: attacker can use JS to grab session ID of every future visitor and come back and assume to be
    that user via the session ID.

Note: the malicious code would bypass the same-origin policy because the code lives on the site.

Countermeasures;
  1) always sanitize user input. Can completely disallow HTML and JS.
  2) escape all user data when displaying it. If you do need to allow users to input
      HTML and JS, then when you print it out make sure to escape it so that the
      browser does not interpret the code.
