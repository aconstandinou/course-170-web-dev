ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../cms"

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get "/"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response['Content-Type']
    assert_includes last_response.body, 'about.txt'
    assert_includes last_response.body, 'changes.txt'
    assert_includes last_response.body,'history.txt'
  end

  def test_route_filename
    get "/history.txt"
    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response['Content-Type']
    assert_includes last_response.body, 'history'
  end

  def test_bad_file_request
    get "/badfile.txt"
    assert_equal 302, last_response.status

    get last_response["Location"]
    assert_equal 200, last_response.status
    assert_includes last_response.body, "badfile.txt does not exist."
  end

  def test_markdown
    get "/aboutmd.md"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "<p>"
  end

  def test_editing_document
    get "/about.txt/edit"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<textarea"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_updating_document
    post "/about.txt", edited_doc: "changed content for ruby minitest"

    assert_equal 302, last_response.status

    get last_response["Location"]
    assert_includes last_response.body, "about.txt has been changed"

    get "/about.txt"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "changed content for ruby minitest"
  end

end
