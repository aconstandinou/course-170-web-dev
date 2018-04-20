############################### ROUTE PARAMETERS ###############################

Parameters added to the URL pattern.

ie: get "/chapters/:number" do end

This will match any route that starts with "/chapters/" followed by a single segment

Values passed to the app thru the URL in this way appear in the params Hash that
  is automatically made available in routes.

# Can access as follows:

get "/chapters/:number" do
  @chapter_number = params[:number] # method 1 (symbol)
  @chapter_number = params["number"] # method 2 (string)
end

# another example
get "/course/:course/instructor/:intructor" do |course, instructor|
  # option 1
  @course_id = params["course"]            # using params hash
  @instructor_id = params["instructor"]
  # option 2
  @course_id = params[:course]             # using params hash
  @instructor_id = params[:instructor]
  # option 3
  @course_id = course                      # This code obtains the parameters from the block parameters.
  @instructor_id = instructor
  erb :course_roster, layout: layout
end
