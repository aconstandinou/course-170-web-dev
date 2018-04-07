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

    get "/", {}, admin_session

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
    get "/badfile.txt", {}, admin_session
    assert_equal 302, last_response.status
    assert_equal "badfile.txt does not exist.", session[:message]

    get last_response["Location"]
    assert_equal 200, last_response.status
  end

  def test_md_doc
    create_document("aboutmd.md", "# Ruby rocks")

    get "/aboutmd.md"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "<h1>"
  end

  def test_editing_document
    create_document("about.txt")

    get "/about.txt/edit", {}, admin_session

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<textarea"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_submit_doc_edits
    create_document("about.txt", "old content")

    post "/about.txt", {edited_doc: "changed content for ruby minitest"}, admin_session
    assert_equal 302, last_response.status
    assert_equal "about.txt has been changed.", session[:message]
    
    get "/about.txt", {}, admin_session
    assert_equal 200, last_response.status
    assert_equal last_response.body, "changed content for ruby minitest"
  end

  def test_view_new_doc_form
    get "/create/document", {}, admin_session
    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_create_document
    post "/create/document", {new_doc_name: "doc_test.txt"}, admin_session
    assert_equal 302, last_response.status
    assert_includes session[:message], "doc_test.txt has been created."

    get "/"
    assert_includes last_response.body, "doc_test.txt"
  end

  def test_create_document_without_filename
    post "/create/document", {new_doc_name: ""}, admin_session
    assert_equal 422, last_response.status
    assert_includes last_response.body, "A name is required."
  end

  def test_delete_file
    create_document("test_doc_to_delete.txt")

    post "/users/signin", {}, admin_session

    post "/delete/test_doc_to_delete.txt"

    assert_equal 302, last_response.status
    assert_includes session[:message], "test_doc_to_delete.txt was deleted."

    get last_response['Location'], {}, admin_session
    assert_equal 200, last_response.status
  end

  def test_signin_page
    get "users/signin"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_good_login_credentials
    post "/users/signin", {:username => "admin", :password => "secret"}
    assert_equal "Welcome!", session[:message]
    assert_equal "admin", session[:username]

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

  ## Now we test for when user is not signed in
  def test_bad_login_create_doc
    post "/create/document", {filename: "test.txt"}

    assert_equal 302, last_response.status
    assert_equal "You must be signed in to do that.", session[:message]
  end

  def test_bad_login_delete_doc
    create_document("test_doc_to_delete.txt")

    post "/delete/test_doc_to_delete.txt"
    assert_equal 302, last_response.status
    assert_equal "You must be signed in to do that.", session[:message]
  end

  def test_bad_login_edit_submission
    post "/create/document", {new_doc_name: "doc_test.txt"}, admin_session
    # then signout
    post "/users/signout"
    # then try to submit update on doc after signing out
    post "/doc_test.txt", {edited_doc: "try to edit doc"}, {}
    assert_equal 302, last_response.status
    assert_equal "You must be signed in to do that.", session[:message]
  end

  def test_bad_login_edit_submission_v2
    create_document("test_doc_to_delete.txt")

    post "/delete/test_doc_to_delete.txt"
    assert_equal 302, last_response.status
    assert_equal "You must be signed in to do that.", session[:message]
  end

end
