################################ VIEW TEMPLATES ################################

Benefits?
- View templates allow us to combine HTML and Ruby code.
- Allows us to reduce duplication of HTML as well as generate dynamic content.
- Without view templates, we would end up writing HTML code into each route within
    the string we return in our response.
  And would include dynamic content via string interpolation.

What do they do?

- Templates (or view templates) are files that contain text that is converted into
    HTML before being sent to a users browser in a response.
- DYNAMIC : allows our web apps to be more dynamic

- ERB (embeded Ruby)
       - embeds Ruby code into another file.
       - ruby code sites between "<%" and "%>"
       - to display ruby values "<%=" and "%>"

require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"                         # library for erb

get "/" do
  erb :home
end

"LAYOUTS"
- view template that wraps around other view templates.
- shared HTML code in a layout, and particular view template will be code specific to that code.

- How?

in "layout.erb", we "<%= yield %>"

- How to invoke layout.erb

erb :list_all
or
erb :list_all, layout: :layout

Note how the yield keyword is used in a layout to indicate where the content
  from the view template will end up.

" TEMPLATE PARAMETERS "
- need to be defined as instance variables in routes.
