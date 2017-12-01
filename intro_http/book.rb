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
- unsafe or reserved chars are not included in the set and have to be converted or encoded
  to conform to this format.

Character  ASCII Code  URL
Space      20          http://www.thedesignshop.com/shops/tommy%20hilfiger.html
!          21          http://www.thedesignshop.com/moredesigns%21.html
+          2B          http://www.thedesignshop.com/shops/spencer%2B.html
#         23           http://www.thedesignshop.com/%23somequotes%23.html

Examples:

# characters must be encoded if:
1. They have no corresponding character within the ASCII character set.
2. The use of the character is unsafe. For example % is unsafe because it is used
   for encoding other characters.
3. The character is reserved for special use within the URL scheme. Some characters
   are reserved for a special meaning; their presence in a URL serve a specific purpose. Characters such as /, ? :, @ and & are all reserved and must be encoded.

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
302           Found                     Requested resrouce has changed temporarily.
                                        Usually results in a redirect.
404           Not Found                 Requested resource cannot be found.
500           Internal Server Error     Server has encountered a generic error.


# 302 Redirect











.
