#inherits methods from ApplicationController (helpers, configuration, etc.)
class UsersController < ApplicationController

  #renders login page form
  get '/login' do
    erb :login
  end

  # Receives the login form (action is login, method is POST)
  # creates a session using a key/value pair.
  post '/login' do
    #Find user. Must include "username:" as key otherwise first username found will be returned.
    @user = User.find_by(username: params[:username])
    #authenticate using email/oassword combo
    if @user.authenticate(params[:password])
      #log the user in/create user session
      session[:user_id] = @user.id #logs user in
      #redirect to user's landing page(show? index? dashboard?)
      redirect "users/#{@user.username}"
    else
    end

  end

  #signup
  get '/signup' do
  end

  #user SHOW route
  get '/users/:username' do
    "this will be the user show route"
  end

end
