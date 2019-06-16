#inherits methods from ApplicationController (helpers, configuration, etc.)
class StoriesController < ApplicationController

  #new
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

  #show
  get '/stories/:id' do
    if !logged_in?
      redirect '/'
    end
    find_story
    erb :'/stories/show'
  end

  #edit
  get '/stories/:id/edit' do
    find_story
    if logged_in?
      if user_story?(@story)
        erb :'/stories/edit'
      else
        redirect "users/#{current_user.username}"
      end
    else
      redirect '/'
    end
  end

  #
  patch '/stories/:id' do
    if logged_in?
      if user_story?(@story)
        @story.update(name: params[:name], author: params[:author])
        redirect "/stories/#{@story.id}"
      else
        redirect "users/#{current_user.username}"
      end
    else
      redirect '/'
    end
  end

  get '/stories' do
    @user = current_user
    @stories = Story.all
    erb :'stories/index'
  end

  private

  def find_story
    @story = Story.find(params[:id])
  end

end
