require 'pry'
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

  get '/posts/:id' do
    post_id = params[:id]
    @post = Post.find(post_id)
    erb :show
  end

  get '/posts/:id/edit' do
    post_id = params[:id]
    @post = Post.find(post_id)
    erb :edit
  end

  delete '/posts/:id/delete' do
    post_id = params[:id]
    post = Post.find(post_id)
    post.destroy
    erb :delete
  end

  patch '/posts/:id' do
    post_id = params[:id]
    post = Post.find(post_id)
    post.update(name: params[:name], content: params[:content])
    redirect "/posts/#{post_id}"
  end

  get '/posts' do
    @posts = Post.all
    #binding.pry
    erb :index
  end

  post '/posts' do
    #use params[] to create a new blog post with ActiveRecord
    Post.create(params)
    redirect "/posts"
  end

end
