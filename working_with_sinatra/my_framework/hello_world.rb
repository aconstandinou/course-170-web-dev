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


# modified 3
# hello_world.rb

require_relative 'advice'

class HelloWorld
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      ['200', {"Content-Type" => "text/html"}, [erb(:index)]]
    when '/advice'
      piece_of_advice = Advice.new.generate
      [
        '200',
        {"Content-Type" => 'text/html'},
        ["<html><body><b><em>#{piece_of_advice}</em></b></body></html>"]
      ]
    else
      [
        '404',
        {"Content-Type" => 'text/html', "Content-Length" => '48'},
        ["<html><body><h4>404 Not Found</h4></body></html>"]
      ]
    end
  end

  private

  # updated erb method

  def erb(filename, local = {})
    b = binding
    message = local[:message]
    path = File.expand_path("../views/#{filename}.erb", __FILE__)
    content = File.read(path)
    ERB.new(content).result(b)
  end
end
