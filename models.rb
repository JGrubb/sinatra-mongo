MongoMapper.database = 'blog'

class Post
  include MongoMapper::Document
  
  key :title, String
  key :body, String
  key :slug, String
  
  timestamps!
  
end