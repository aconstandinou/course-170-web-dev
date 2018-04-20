# Extras Study Guide
- How does HTTP simulate state?
  (A)
  1 - Sessions: server sends some form of unique token to client.
                Whenever client makes request to that server, client appends token as part of request.
                Passing "session id" back and forth between client and server creates
                  sense of persistent connection between requests.
                Note: Every request must be inspected for session identifier.
                      If it does, server must check to ensure session id is still valid.
                      Then, server needs to retrieve data based on session id.
                      Server then needs to recreate the app state and send it back to client as response.
  2 - Cookies: piece of data sent to server and stored in client during request/response cycle.
               small files stored in browser and contain session info.
  3 - Ajax?

  Data Storage: session data is stored on server, client side cookie is compared to server-side session
                data.

- POST vs GET
- route matching and `before` block
- what is templating language

For the code challenge, theyll give you some HTML code to start with, youll
  need to implement 2-3 pages with form inputs and returning the data in another page.
