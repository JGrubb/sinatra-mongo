require 'bundler/setup'
require 'sinatra'
require 'mongo_mapper'
require 'erb'
require 'redcarpet'

require './models'
require './text_helpers'

get '/' do
  @posts = Post.sort(:created_at => -1).limit(5)
  erb :index
end

get '/all' do
  @posts = Post.sort(:created_at => -1)
  erb :all
end

get '/posts/:slug' do
  @post = Post.find_by_slug(params[:slug])
  erb :show
end