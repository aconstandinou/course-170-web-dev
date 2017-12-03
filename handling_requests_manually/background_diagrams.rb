# Lets setup a working mental model of how HTTP and server-side dev works.


# CLIENT<->SERVER

- typical approach to how web dev works:

          ------ http request ----->
client                                    server
          <----- http response -----

- to understand server-side dev, we need to zoom in a bit to the "server"

         ------------------------- web server
server                                   |
         ------------------------- application server
                                         |
                                   data store

- 3 primary server-side infrastructure;
  1. web server
  2. application server
  3. data store

1. web server; responds to static assets: files, images, css, JS, etc.
               requires no data processing so a simple web server can handle this.

2. application server; where an app or business logic resides. Handles complicated
                       requests and where server-side code lives when deployed.

3. data store; where the app server persistently consults, like a relational DB,
               to retrieve or create data. Data stores can also be simply files,
               key/value stores, document stores and many other variations as long
               as it can save data in some format for later retrieval and processing.

# HTTP over TCP/IP

- within the request/response cycle:

                        -----------    TCP/IP Connection
                 -------               -> "GET /index.html HTTP 1.1"
http request  ---
http response ---                      "<html><body>My Homepage</body></html>"
                 -------
                        -----------

- HTTP relies on TCP/IP connection
- remember, there are many different layers for client to send a request to server.
  coordination between all these machines = protocols at all layers
  ie: application to transport to network to physical
- HTTP = application layer protocol; convention or agreement between two parties.
  ie: lets say my weather service website provides historical data for date + zip code.
      we agree that the request needs to be done in a certain format,
      ie: "MM/DD/YYYY;ZIPCODE"
- TCP/IP: more complicated as it represents lower layers in the communication stack.
          its a set of protocols on how systems should communicate with each other
          over the internet.
          known as Open Systems Interconnection model (OSI)

################################### MAIN POINT ###############################
- HTTP uses TCP/IP under the hood as the transport and network layers
- TCP/IP thats doing all the heavy lifting and ensuring that the request/response cycle
         gets completed between your browser and the server.

####################### Coding Along with this Course #######################

- since we wont have a DB in this course, our "server-side" infrastructure will be
  just an app server.

#{model}

server -----------------------------> application server

You might also notice that well use a class that starts with TCP when we create
  a server. This is because TCP is the transport layer for HTTP requests, so
  dont be surprised to see that. When we do write our own TCP servers, we might
  call them "HTTP servers", because were sending HTTP-compliant requests and
  responses using the TCP connection. Keep the below diagram in your head as you
  follow along with creating our own TCP (or HTTP) server:

#{model}

                                                  request      response
                                                      |            ^
                                                      |            |
                                                      v            |
         ---------------------------------           [   TCP SERVER   ]
server
         ---------------------------------           [   RUBY CODE   ]




.
