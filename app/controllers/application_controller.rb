
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    redirect '/articles'
  end

  get '/articles/new' do 
    erb :new
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do 
    @article = Article.find(params[:id])
    new_updates = {
      title: params[:title],
      content: params[:content]
    }
    @article.update(new_updates)

    redirect "/articles/#{@article.id}" 
  end

  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do 
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.delete
  end

end
