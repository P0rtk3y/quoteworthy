require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public' #tells sinatra where public files such as images are located
    set :views, 'app/views' #where Sinatra will look when files are rendered

    enable :sessions #logs a user in using a sessions hash
    set :session_secret, "quote_a_bookling" #extra layer of security
  end

  get '/' do
    if logged_in?
      redirect "/users/#{current_user.username}"
    else
      erb :welcome
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def user_story?(story)
      story.user_id == current_user.id
    end 
  end

end
