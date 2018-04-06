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

  def session
    last_request.env["rack.session"]
  end

  def admin_session
    { "rack.session" => { username: "admin" } }
  end
  
  def test_index
    create_document "about.md"
    create_document "changes.txt"

    get "/"

    assert_equal 302, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes session[:message], "about.md"
    assert_includes session[:message], "changes.txt"

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
    assert_equal 302, last_response.status
    assert_equal session[:message], "badfile.txt does not exist."
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
    assert_includes session[:message], "about.txt has been changed"

    get "/about.txt"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "changed content for ruby minitest"
  end

  def test_view_new_doc_form
    get "/create/document"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_create_document
    post "/create/document", new_doc_name: "doc_test.txt"
    assert_equal 302, last_response.status
    assert_includes session[:message], "doc_test.txt has been created."

    get "/"
    assert_includes last_response.body, "doc_test.txt"
  end

  def test_create_document_without_filename
    post "/create/document", new_doc_name: ""
    assert_equal 422, last_response.status
    assert_includes last_response.body, "A name is required."
  end

  def test_delete_file
    create_document("test_doc_to_delete.txt")

    post "/delete/test_doc_to_delete.txt"
    assert_equal 302, last_response.status
    assert_includes session[:message], "test_doc_to_delete.txt was deleted."

    get "/"
    refute_includes last_response.body, "test_doc_to_delete.txt"
  end

  def test_signin_page
    get "users/signin"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_good_login_credentials
    post "users/signin", username: "admin", password: "secret"
    assert_equal 302, last_response.status
    assert_includes session[:message], "Signed in as"

    get last_response["Location"]
    assert_includes last_response.body, "Signed in as admin"
  end

  def test_bad_login_credentials
    post "users/signin", username: "bad", password: "bad"
    assert_equal 422, last_response.status
    assert_nil session[:username]
    assert_includes last_response.body, "Invalid credentials"
  end

  def test_signout
    get "/", {}, {"rack.session" => { username: "admin" } }
    assert_includes last_response.body, "Signed in as admin"

    post "/users/signout"
    get last_response["Location"]

    assert_nil session[:username]
    assert_includes last_response.body, "You have been signed out"
    assert_includes last_response.body, "Sign In"
  end
end
