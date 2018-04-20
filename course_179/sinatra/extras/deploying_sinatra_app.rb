- Deploying to server or internet.

# CONFIGURING OUR APP FOR DEPLOYMENT

1. require "sinatra/reloader" if development?
  prevents app from reloading in production
  development? or production? are determined by current value of RACK_ENV environment
    variable.

2. Gemfile -> specify ruby version

3. Configure app to use production web server (Gemfile)

group :production do
  gem "puma"
end

  Why? Because WEBrick is single threaded (must process one request at a time)
       Puma is multi-threaded (can handle multiple requests at a time)
       DOESNT MEAN FASTER!

4. create config.ru file in root, a.k.a for Puma to know how to start app

require "./book_viewer"
run Sinatra::Application

5. create Procfile
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}

# A project's Procfile determines what processes should be started when the application boots up

6. test Procfile locally
$ heroku local

############################## CREATING HEROKU APP ##############################
# https://launchschool.com/lessons/6a67df63/assignments/5b926dbb

1. Create Heroku app using # heroku apps:create $NAME
  $NAME is the app name you wish to use.
2. push project to Heroku app using # git push heroku master
3. visit app and verify everything is working.
4. Recall, we are expecting Heroku to automatically set RACK_ENV environment var
   to "production".
   To see this -> # $ heroku config

################################### SUMMARY ####################################
- Procfile defines what types of processes are provided by the application
  and how to start them.
  Ex: web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}

  "web server" -> puma
  "port number" -> port number
  "process" ->

# https://launchschool.com/quizzes/a2d33f12

- config.ru tells the web server how to start the application. In this project,
  we require the file that contains the Sinatra application and then start it.
- While WEBrick is a fine web server for development, it is better to use a
  production-ready web server such as Puma when deploying a project.
- Puma is a threaded web server, which means that it can handle more than one
  request at a time using a single process. As a result, Puma will perform much
  better for most applications.
- A specific version of Ruby can be specified in the Gemfile to ensure that the
  same version is used in both development and production.
- can set environment variables through .env file
  Why woudl you want to?
    - To set configuration that is specific to a production env.
    - To store sensitive info that you may not want to store within app repo.








.
