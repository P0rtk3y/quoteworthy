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

  #SHOW

  #INDEX

  #NEW
  #EDIT
  #PATCH
  #DELETE

end
