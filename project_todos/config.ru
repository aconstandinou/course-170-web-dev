# new
require 'rubygems'
require './todo'

use Rack::ShowExceptions

run Sinatra::Application
