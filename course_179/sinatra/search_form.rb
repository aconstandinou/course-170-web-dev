################################# SEARCH FORM #################################
# https://launchschool.com/lessons/ee756b04/assignments/09d7452c
So far parameters have been extracted from the URL.
There are two other ways to get data into the params hash:

1. Using query parameters in the URL
2. By submitting a form using a POST request

How it works?
- When a form is submitted, the browser makes a HTTP request.
- This request is made to the path or URL specified in the "action" attribute of the form element.
- The method attribute of the form determines if the request made will use GET or POST.
- The value of any input elements in the form will be sent as parameters.
  The keys of these parameters will be determined by the "name" attribute of the corresponding input element.

# HTML CODE
<h2 class="content-subhead">Search</h2>

<form action="/search" method="get">
  <input name="query" value="<%= params[:query] %>">
  <button type="submit">Search</button>
</form>

# Corresponding Ruby Code
get "/search" do
  @results = chapters_matching(params[:query])
  erb :search
end

Were using GET as the method for this form because performing a search doesnt modify any data.
  If our form submission was modifying data, we would use POST as the forms method.
