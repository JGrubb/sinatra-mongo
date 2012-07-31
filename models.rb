MongoMapper.database = 'blog'

class Post
  include MongoMapper::Document
  
  key :title, String, :required => true
  key :body, String, :required => true
  key :slug, String, :required => true
  
  validates :slug, :uniqueness => true
  
  timestamps!
  
  many :comments
  
end

class Comment
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :email, String
  key :body, String
  
  belongs_to :post
end