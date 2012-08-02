require 'bundler/setup'
require 'sinatra'
require 'mongo_mapper'
require 'erb'
require 'redcarpet'
require 'date'

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
  @post.comments.build
  erb :show
end

get '/posts/:slug/edit' do
  @post = Post.find_by_slug(params[:slug])
  @action = "edit"
  erb :form
end

post '/posts/:slug/edit' do
  @post = Post.find_by_slug(params[:slug])
  if @post.save(params[:post])
    redirect "/posts/#{@post.slug}"
  else
    'whoops'
  end
end

post '/posts/:slug/delete' do
  @post = Post.find_by_slug(params[:slug])
  if @post.delete
    redirect "/"
  else
    'whoops'
  end
end

post '/posts/:slug/comment' do
  @post = Post.find_by_slug(params[:slug])
  @post.comments << Comment.new(params[:comment])
  if @post.save
    redirect "/posts/#{@post.slug}"
  else
    env['sinatra.error'].name
  end
end

post '/posts/:slug/:comment_id/delete' do
  @post = Post.find_by_slug(params[:slug])
  @post.comments.find(:comment_id).delete
  #@comment.delete
  redirect "/posts/#{@post.slug}"
end
  
get '/new' do
  @post = Post.new
  @action = "new"
  erb :form
end

post '/new' do
  @post = Post.new(params[:post])
  @post.slug = sluggify(@post.title)
  if @post.save
    redirect "/posts/#{@post.slug}"
  else
    'whoops'
  end
end

def sluggify(str)
  a = str.split(" ")
  b = a.map { |el| el.downcase }.join("-")
  if Post.find_by_slug(b)
    b << "-#{Post.count + 1}"
  else
    b
  end
end