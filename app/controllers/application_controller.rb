require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "quote_a_bookling"
  end

  get "/" do
    erb :welcome
  end

  #SHOW

  #INDEX

  #NEW
  #EDIT
  #PATCH
  #DELETE

end
