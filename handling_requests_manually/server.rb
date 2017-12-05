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

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/plain\r\n\r\n"

  http_method, path, params = parse_request(request_line)
  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  rolls.times do
    roll = rand(sides)+1
    client.puts roll.to_s
  end

  client.close
end
