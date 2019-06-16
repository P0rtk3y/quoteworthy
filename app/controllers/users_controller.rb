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
    if @user = User.find_by(username: params[:username])
      #authenticate using email/oassword combo
      if @user.authenticate(params[:password])
        #log the user in/create user session
        session[:user_id] = @user.id #logs user in
        #redirect to user's landing page(show? index? dashboard?)
        redirect "users/#{@user.username}"
      else
        flash[:notice] = "Invalid login. Please try again."
        redirect '/login'
      end
    else
      redirect '/signup'
    end 
  end

  #signup
  get '/signup' do
    erb :signup
  end

  post '/users' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/users/#{@user.username}" #creates a new HTTP request
    else
      flash[:notice] = "Invalid Entry. Please complete all fields."
      redirect '/signup'
    end
  end

  #user SHOW route
  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
