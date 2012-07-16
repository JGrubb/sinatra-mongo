require 'bundler/setup'
require 'sinatra'
require 'mongo_mapper'
require 'erb'

get '/' do
  'hello!'
end