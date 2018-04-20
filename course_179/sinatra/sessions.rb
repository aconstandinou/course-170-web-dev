################################### SESSIONS ###################################
# http://guides.rubyonrails.org/security.html#sessions

# http://sinatrarb.com/intro.html

# https://launchschool.com/books/http/read/statefulness#sessions

Q - What is a session?
A - A session is just a place to store data during one request that you can read during later requests.
    Its a form of aggregation of data that spans multiple request-response cycles
    We know HTTP is stateless, and therefore this allows us a way to create a form of
      persistent state.
    Common usage would be for tracking whether a user is logged in.

Q - Where is it stored?
A - Session data is stored on the server.
    Once data is stored in a session, a session identifier is included in the response
    back to the client, and that session identifier is stored in the clients browser.

# https://launchschool.com/books/http/read/statefulness#sessions

Q - How is it used?
A - Once data is stored in a session, a session identifier is sent in the response
    and saved on the clients web browser. This is included in future requests to the web
    server.
    On every request, the server checks for a session identifier, and if it exists whether it is still valid.
    If it is valid, then the server retrieves the data based on the session identifier.
    Server then needs to recreate the application state, and is send back to the client
    as a response.

    When a request comes in, it includes some identifier that tells the server
      to retrieve specific session data, which represents the app state for that user.

EXTRA NOTES :
when a user sends in a request, they send in data via request parameters.
  These request parameters are valid only for 1 request.
  For sessions, however, you need some persistent identifier to come in so
  you can know that its the same user. A browser cookie is where this identifier
  is stored. A browser cookie is a small space allocated by the browser for a particular website.

There are ways, for example, to maintain a session without cookies at all.
(its done by always sending users a redirect with an identifier in the URL, so
  when users interact w/ the website, that identifier will always be sent in
  as part of the request, as long as the user doenst modify it)
(this also implies if you copy/paste the url to someone else, they immediately have your session)

TRUE OR FALSE
- copying a session identifier from one browser, into another enables identical state?
  TRUE, since the original session identifier can be recalled on the server back to that state.
  this is known as session hijacking.

# Setup in our app
configure do                               # configure block is enabling these settings
  enable :sessions
  set :session_secret, 'secret'
end
