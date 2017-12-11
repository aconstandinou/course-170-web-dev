# hello_world.rb

#class HelloWorld
#  def call(env)
#    ['200', {'Content-Type' => 'text/plain'}, ['Hello World!']]
#  end
#end

# modified # 1
# hello_world.rb

#require_relative 'advice'     # loads advice.rb
#
#class HelloWorld
#  def call(env)
#    case env['REQUEST_PATH']
#    when '/'
#      ['200', {"Content-Type" => 'text/plain'}, ["Hello World!"]]
#    when '/advice'
#      piece_of_advice = Advice.new.generate    # random piece of advice
#      ['200', {"Content-Type" => 'text/plain'}, [piece_of_advice]]
#    else
#      [
#        '404',
#        {"Content-Type" => 'text/plain', "Content-Length" => '13'},
#        ["404 Not Found"]
#      ]
#    end
#  end
#end

# modified # 2
# hello_world.rb

# require_relative 'advice'
#
# class HelloWorld
#   def call(env)
#     case env['REQUEST_PATH']
#     when '/'
#       [
#         '200',
#         {"Content-Type" => 'text/html'},
#         ["<h2>Hello World!</h2>"]
#       ]
#     when '/advice'
#       piece_of_advice = Advice.new.generate
#       [
#         '200',
#         {"Content-Type" => 'text/html'},
#         ["<html><body><b><em>#{piece_of_advice}</em></b></body></html>"]
#       ]
#     else
#       [
#         '404',
#         {"Content-Type" => 'text/html', "Content-Length" => '48'},
#         ["<html><body><h4>404 Not Found</h4></body></html>"]
#       ]
#     end
#   end
# end

# modified 3
# hello_world.rb

# require_relative 'advice'
#
# class HelloWorld
#   def call(env)
#     case env['REQUEST_PATH']
#     when '/'
#       template = File.read("views/index.erb")
#       content = ERB.new(template)
#       ['200', {"Content-Type" => "text/html"}, [content.result]]
#     when '/advice'
#       piece_of_advice = Advice.new.generate
#       [
#         '200',
#         {"Content-Type" => 'text/html'},
#         ["<html><body><b><em>#{piece_of_advice}</em></b></body></html>"]
#       ]
#     else
#       [
#         '404',
#         {"Content-Type" => 'text/html', "Content-Length" => '48'},
#         ["<html><body><h4>404 Not Found</h4></body></html>"]
#       ]
#     end
#   end
# end

# app.rb
# app.rb

require_relative 'monroe'
require_relative 'advice'

class App < Monroe
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      status = '200'
      headers = {"Content-Type" => 'text/html'}
      response(status, headers) do
        erb :index
      end
    when '/advice'
      status = '200'
      headers = {"Content-Type" => 'text/html'}
      piece_of_advice = Advice.new.generate
      response(status, headers) do
        erb :advice, message: piece_of_advice
      end
    else
      status = '404'
      headers = {"Content-Type" => 'text/html', "Content-Length" => '61'}
      response(status, headers) do
        erb :not_found
      end
    end
  end
end
