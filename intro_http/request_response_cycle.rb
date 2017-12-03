# Questions

# 1. What are the required components of an HTTP request? What are the additional optional components?
required: method, path and host header.
additional: parameters, all other headers and message body

# 2. What are the required components of an HTTP response? What are the additional optional components?
required: status
additional: headers (content-Type), body

# 3. What determines whether a request should use GET or POST as its HTTP method?
GET requests should only retrieve content from the server. They can generally
  be thought of as "read only" operations, although there are some subtle
  exceptions to this rule. For example, consider a webpage that tracks how
  many times it is viewed. GET is still appropriate since the main content
  of the page doesnt change.

POST requests involve changing values that are stored on the server. Most
  HTML forms that submit their values to the server will use POST. Search
  forms are a noticeable exception to this rule, and they often use GET
  since they are not changing any data on the server, only viewing it.


# Video notes:
http://todos.com/tasks?due=today

once client makes a connection, we send a Request which includes:
- Method: GET or POST
- Path: /tasks
- Parameters: ?due=today
- in HTTP 1.1, now we include host name: todos.com

server receives request and performs the following:
- verify user session
- load tasks from database
- render HTML

then server sends response:
- status (numeric code and short text)
- headers (collection of metadata of the contents): content-Type
                                                    ie for web page: text/html
- body (bulk of data): <html><body>

# SUMMARY

- HTTP is a text-based protocol that is the foundation of the web.
- There are two parties involved in HTTP: the client and the server.
- A complete HTTP interaction involves a request which is sent from the
  client to the server, and a response which is sent from the server to the
  client.
- A request is sent to a host and must include a method and a path. It may
  also include parameters, headers, or a body.
- GET is the HTTP method used to retrieve a resource from the server.
- A response must include a status. It may also include headers or a body.
- A 200 OK status in a response means the request was successful.
- Modern web browsers include debugging tools that allow you to inspect the
  HTTP activity of a page.





  .
