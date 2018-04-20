################################## REDIRECTING #################################
# https://launchschool.com/lessons/ee756b04/assignments/35470d96

1) # this one gets executed when it cant find a route
not_found do
  "That page was not found"
end

2) #method redirect within a route
redirect "/a/good/path"

 - WHAT HAPPENS WITHIN HTTP RESPONSE?
1) HTTP Response : sets "Location" header in HTTP response + status code value to range 3XX
2) Browser then sees the status code in range 3XX and is able to confirm the status code as a redirect,
   looks at "Location" header and makes a GET request to the provided URL

 - WHY IS IT NEEDED?
It is common to redirect a user as the result of creating or updating some data,
  such as when a web site redirects a user to an order confirmation page after
  a payment form is successfully submitted.
- Access right issues, as in, logged in user access vs. not logged in.
- Missing page. Being able to redirect the user back to an actual page.
- After handling a POST request, we would redirect to show the changed state and new data.

Essentially, redirect at its root allows us to provide a new state to the user.
