require 'sequel'
require 'mongo'

DB = Sequel.connect(
  :adapter => 'mysql',
  :host     => 'localhost',
  :database => 'blog_development',
  :user     => "root",
  :password => "root"
)

posts = DB[:posts]

con = Mongo::Connection.new
db  = con['blog']
mongo_posts = db['posts']

posts.order(:created_at, "ASC").each_with_index do |post, i|
  puts post
  mongo_posts.save({:title => post[:title], :body => post[:body], :created_at => post[:created_at], :updated_at => post[:updated_at], :slug => "#{post[:slug]}-#{i}", :published => post[:published]})
end

