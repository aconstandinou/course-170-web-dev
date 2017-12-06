# Lesson: Persisting State in the URL

# In our example, we want to increment and decrement depending on the link the user
# clicks on. Since HTTP is stateless we need a way to track this.
# We will use the URL to store this counter. Therefore counter needs to be a param.

require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split(" ")
  path, params = path_and_params.split("?")
  params = (params || "").split("&").each_with_object({}) do |pair, hash|
    key, val = pair.split("=")
    hash[key] = val
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)         # used a port # we're not using
loop do
  client = server.accept # waits until a request is made to server -> accepts it -> opens connection to client

  request_line = client.gets # using gets to get first line of whatever the request is
  next if !request_line || request_line =~ /favicon/
  puts request_line
  next unless request_line
  http_method, path, params = parse_request(request_line)

  client.puts "HTTP/1.1 200 OK"           # video added this line
  client.puts "Content-Type: text/html"   # video modified this from plain to html
  client.puts                             # adds empty line
  client.puts "<html>"                    # print out html tag
  client.puts "<body>"                    # print out body tag
  client.puts "<pre>"                     # pre tag: preserve white space+print out as its seen
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"
  number = params["number"].to_i
  client.puts "<p>The current number is #{number}.</p>"

  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "<a href='?number=#{number - 1}'>Subtract one</a>"

  client.puts "</body>"                         # close body tag
  client.puts "</html>"                         # close html tag
  client.close
end
