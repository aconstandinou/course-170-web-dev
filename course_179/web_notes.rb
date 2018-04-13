#################################### WEB #####################################

###############################################################################
# How does HTML form interact with server-side code that processess it
###############################################################################
"
LS Version

- When a form is submitted, the browser makes a HTTP request.
- This request is made to the path or URL specified in the action attribute of the form element.
- The method attribute of the form determines if the request made will use GET or POST.
- The value of any input elements in the form will be sent as parameters.
    The keys of these parameters will be determined by the name attribute of the corresponding input element.
"

Within the form element:

- [action] attribute specifies URL path (also known as route in Sinatra)
- [method] attribute specifies HTTP method (GET or POST)
- value of [input] tags will be sent as parameters.
- Our params key will be name attribute of the corresponding [input] element

Example: this form uses a POST HTTP method with Sinatra route "/create/document"
         our input type will be text and the name will be "new_doc_name"
         to access the content within our Sinatra app, we can access it via
         params hash and key for our hash will = "new_doc_name"

<form method="post" action="/create/document">
  <p>Add a new document:
    <input type="text" name="new_doc_name">
  </p>
  <button type="submit">Create</button>
</form>

In other words: the name attribute of an input or textarea tag determines the param name that
can be used to access the inputs value when the form is submitted.

###############################################################################
# Why is user enter content a security risk? How can you mitigate it?
###############################################################################

"HTTPS security:" https://launchschool.com/books/http/read/security

'User entered security'
https://launchschool.com/lessons/d755e7ec/assignments/70e3be0a

- The fact that webpages are building HTML dynamically means that there
  are lots of opportunities for someone to influence what code is written
  into the page. And if they are able to modify the code in the page, they
  have all the access they need to steal data or, potentially, credentials.

"<FOR HTML>"

  An example is provided highlighting that in our Todo App, there was a way
for JS code to be submitted via the 'New Form Submission' and we would have had
no idea that was the case.

Options - Sanitize HTML by escaping values that come in from untrusted sources
https://launchschool.com/lessons/d755e7ec/assignments/466bcca0

1) "ESCAPE" Manually: involves replacing certain characters in the text with HTML entities
built-in method: "Rack::Utils.escape_html"

already available in Sinatra, but can create helper method for it

helpers do
  def h(content)
    Rack::Utils.escape_html(content)
  end
end

in view template

<h3><%=h todo[:name] %></h3>

" ISSUE: developer needs to do this in every place where untrusted input is being rendered"

2) "escape" all output automatically by adding below code to an app.

Step 1)
configure do
  set :erb, :escape_html => true
end

Step 2) above code would escape all code in our site. So replace all "<%=" with "<%=="
        and this disables auto-escaping.
#------------------------------------------------------------------------------#
https://launchschool.com/lessons/e44c6e90/assignments/50102300

- Notes on how to 'mitigate risk'

for file names -> use File.basename to strip off anything other than file name.
               -> identify filenames by index rather than name.
               -> can also create a method with cases -> "whitelisting"

              def load_file_content(path)
                content = File.read(path)
                case File.extname(path)
                when ".txt"
                  headers["Content-Type"] = "text/plain"
                  content
                when ".md"
                  erb render_markdown(content)
                end
              end

SIDE NOTE -> To summarize, try to keep the following guidelines in mind while developing web applications:
             1. Avoid using parameters to construct file paths if at all possible.
             2. Use whitelisting to explicitly define what is allowed.
             3. Try to think like a person that is attempting to alter the behavior
                of your software. Is it possible to introduce an unexpected value
                into the system through expected means such as parameters?


.
