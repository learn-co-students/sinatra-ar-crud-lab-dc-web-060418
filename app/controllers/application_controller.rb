
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do
    erb :new
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.update(name: params[:name], content: params[:content])
    erb :show
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.destroy
    erb :delete
  end

  post '/posts' do
    Post.create(params)
    erb :index
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end


end
