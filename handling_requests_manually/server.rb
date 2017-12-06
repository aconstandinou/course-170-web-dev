### OLD CODE
=begin
require "socket"

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/plain\r\n\r\n"
  client.puts rand(6)+1

  client.close
end
=end

# we'd like to use the URL to dictate how many dice we need and
# how many sides we need on our dice.
# CURRENT URL:
# http://localhost:3003

# reminder - breaking down the URL
# http://     localhost     :3003      /
# protocol    host          port       path

# key/value parameters in our URL can help
# '?' dictates where the path ends and the query begins.

# NEW URL (two parameters)
# http://localhost:3003?rolls=2&sides=6

## NEW CODE
require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split(" ")
  path, params = path_and_params.split("?")
  params = params.split("&").each_with_object({}) do |pair, hash|
    key, val = pair.split("=")
    hash[key] = val
  end

  [http_method, path, params]
end

#server = TCPServer.new("localhost", 3003)         # used a port # we're not using
#loop do
#  client = server.accept # waits until a request is made to server -> accepts it -> opens connection to client
#
#  request_line = client.gets # using gets to get first line of whatever the request is
#  next if !request_line || request_line =~ /favicon/
#  puts request_line
#
#  client.puts "HTTP/1.1 200 OK"
#  client.puts "Content-Type: text/plain\r\n\r\n"
#
#  http_method, path, params = parse_request(request_line)
#  rolls = params["rolls"].to_i
#  sides = params["sides"].to_i
#
#  rolls.times do
#    roll = rand(sides)+1
#    client.puts roll.to_s
#  end
#
#  client.close
#end


# Lecture Video: Sending a Complete Response

# - previous code isnt returning valid response to browser
# - were simply sending a text and not a proper HTTP response
#   a valid response would include: status, headers (if any), body
#   (bulk of data being sent back)
# SOME NEGATIVES: we have HTML code and actual code altogether = MESSY
#                 Sinatra will clarify this and help extract out the data.

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

  client.puts "<h1>Rolls!</h1>"
  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  rolls.times do
    roll = rand(sides)+1
    client.puts "<p>", roll,"</p>"
  end
  client.puts "</body>"                         # close body tag
  client.puts "</html>"                         # close html tag
  client.close
end
