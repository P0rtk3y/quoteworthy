#inherits methods from ApplicationController (helpers, configuration, etc.)
class StoriesController < ApplicationController

  #new
  get '/stories/new' do
    erb :'/stories/new'
  end

  post '/stories' do
    redirect_if_not_logged_in
    if params[:name] != "" && params[:author] != ""
      @story = Story.create(name: params[:name], author: params[:author], user_id: current_user.id)
      redirect "/stories/#{@story.id}"
    else
      flash[:notice] = "Invalid Entry. Please complete all fields."
      redirect '/stories/new'
    end
  end

  #show
  get '/stories/:id' do
    redirect_if_not_logged_in
    find_story
    @quotes = Quote.all.select{|quote| quote.story_id == params[:id].to_i}
    erb :'/stories/show'
  end

  #edit
  get '/stories/:id/edit' do
    redirect_if_not_logged_in
    find_story
    if user_story?(@story)
      erb :'/stories/edit'
    else
      redirect "users/#{current_user.username}"
    end
  end

  #
  patch '/stories/:id' do
    redirect_if_not_logged_in
    find_story
    if params[:name] != "" && params[:author] != ""
      if user_story?(@story)
        @story.update(name: params[:name], author: params[:author])
        redirect "/stories/#{@story.id}"
      else
        redirect "users/#{current_user.username}"
      end
    else
      flash[:notice] = "Invalid Entry. Please complete all fields."
      redirect "/stories/#{@story.id}/edit"
    end
  end

  get '/stories' do
    @stories = Story.all
    erb :'stories/index'
  end

  delete '/stories/:id' do
    find_story
    if user_story?(@story)
      @story.destroy
    end
    redirect '/stories'
  end

  private #helper methods scoped to class

  def find_story
    @story = Story.find(params[:id])
  end


end
