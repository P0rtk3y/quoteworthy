#inherits methods from ApplicationController (helpers, configuration, etc.)
class QuotesController < ApplicationController

  get '/stories/:id/quotes/new' do
    find_story
    erb :'/quotes/new'
  end

  post '/stories/:id/quotes' do
    if !logged_in?
      redirect '/'
    end

    if params[:content] != ""
      find_story
      @quote = Quote.new(content: params[:content], user_id: current_user.id, story_id: params[:id])
      @quote.save
      redirect "/stories/#{@story.id}"
    else
      flash[:notice] = "Invalid Entry. Please complete all fields."
      redirect '/stories/:id/quotes/new'
    end
  end

  get '/stories/:id/quotes/edit' do
    if logged_in?
      find_story
      if user_story?(@story)
        @quotes = Quote.all.select{|quote| quote.story_id == params[:id].to_i}
        erb :'/quotes/edit'
      else
        redirect "users/#{current_user.username}"
      end
    else
      redirect '/'
    end
  end

  patch '/stories/:id/quotes' do
    if logged_in?
      find_story
      if user_story?(@story)
        @quotes = Quote.all.select{|quote| quote.story_id == params[:id].to_i}
          @quotes.map do |quote|
            quote.update(content: (params[quote.id.to_s] if params[quote.id.to_s] != ""))
          end
        @quotes
        redirect "/stories/#{@story.id}"
      else
        redirect "users/#{current_user.username}"
      end
    else
      redirect '/'
    end
  end

  delete '/stories/:id/quotes' do
    find_story
    if user_story?(@story)
      @quotes = Quote.all.select{|quote| quote.story_id == params[:id].to_i}
      @quotes.destroy
    end
    redirect "/stories/#{@story.id}"
  end

  private

  def find_story
    @story = Story.find(params[:id])
  end

end
