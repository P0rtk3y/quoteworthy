require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public' #tells sinatra where public files such as images are located
    set :views, 'app/views' #where Sinatra will look when files are rendered

    enable :sessions #logs a user in using a sessions hash
    set :session_secret, "quote_a_bookling" #extra layer of security
  end

  get '/' do
    erb :welcome
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

end
