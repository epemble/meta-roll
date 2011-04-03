### MODELS
require 'dm-core'
require 'dm-validations'


class User
  include DataMapper::Resource
  
  property :id,         Serial
  property :name,       String,   :required => true
  property :pass,       String,   :required => true
  property :email,      String,   :required => true
  property :verified,   Boolean,  :default => false
  
  has n, :characters
end

class Character
  include DataMapper::Resource
  
  property :id,         Serial
  property :name,       String,   :required => true
  property :race,       String
  property :class,      String
  property :visible,    Boolean,  :default => false
  property :type,       Discriminator, :required => true

  has 1, :sheet, :required => false
  belongs_to :user
  belongs_to :adventure, :required => false
  
  def self.visible
    all(:visible => true)
  end
end

class GM          < Character; end
class NPC         < Character; end
class Adventurer  < Character
  property :ac,     Integer
  property :currhp, Integer
end

class Sheet
  include DataMapper::Resource
  
  property :id,         Serial
  # ...
  
  belongs_to :character
end

class Adventure
  include DataMapper::Resource
  
  property :id,           Serial
  property :name,         String
  property :created_on,   Date, :required => true
  property :description,  Text
  
  belongs_to :user
  has n, :characters
  has n, :posts
end

class Post
  include DataMapper::Resource
  
  property :id,         Serial
  property :created_at, DateTime, :required => true
  property :text,       Text,     :required => true
  property :ooc,        Text
  
  belongs_to :character # author
  belongs_to :adventure
#  has n, :recipients
#  has n, :viewers, 'Character', :through => :recipients, :via => :character
end

#class Recipient
#  include DataMapper::Resource
  
#  belongs_to :post,       :key => true
#  belongs_to :character,  :key => true
#end