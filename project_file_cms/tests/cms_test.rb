ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "fileutils"

require_relative "../cms"

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    FileUtils.mkdir_p(data_path)
  end

  def teardown
    FileUtils.rm_rf(data_path)
  end

  def create_document(name, content = "")
    File.open(File.join(data_path, name), "w") do |file|
      file.write(content)
    end
  end

  def test_index
    create_document "about.md"
    create_document "changes.txt"

    get "/"

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"

  end

  def test_route_filename
    create_document("history.txt", "history is awesome")

    get "/history.txt"

    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response['Content-Type']
    assert_includes last_response.body, 'history'
  end

  def test_document_not_found
    get "/badfile.txt"
    assert_equal 302, last_response.status

    get last_response["Location"]
    assert_equal 200, last_response.status
    assert_includes last_response.body, "badfile.txt does not exist."
  end

  def test_viewing_markdown_doc
    create_document("aboutmd.md", "# Ruby rocks")

    get "/aboutmd.md"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "<h1>"
  end

  def test_editing_document
    create_document("about.txt")

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
