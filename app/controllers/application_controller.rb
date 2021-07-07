
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/posts'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    Post.create({:name => params[:name], :content => params[:content]})
    redirect '/posts'
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    begin
      post = Post.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      "No such post"
    else
      @posts = [post]
      erb :index
    end
  end

  get '/posts/:id/edit' do
    begin
      @post = Post.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      "No such post"
    else
      erb :edit
    end
  end

  patch '/posts/:id' do
    begin
      post = Post.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound => e
      "No such post"
    else
      post.update(name: params[:name])
      post.update(content: params[:content])
      redirect "/posts/#{post.id}"
    end
  end

  delete '/posts/:id/delete' do
    begin
      post = Post.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound => e
    else
      post.destroy
    end

    redirect '/posts'
  end
end
