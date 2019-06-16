#inherits methods from ApplicationController (helpers, configuration, etc.)
class StoriesController < ApplicationController

  get '/stories/new' do
    erb :'/stories/new'
  end

  post '/stories' do
    if !logged_in?
      redirect '/'
    end

    if params[:name] != "" && params[:author] != ""
      @story = Story.create(name: params[:name], author: params[:author], user_id: current_user.id)
      redirect "/stories/#{@story.id}"
    else
      redirect '/stories/new'
    end
  end

end
