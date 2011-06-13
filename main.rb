# main.rb
require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require './rollmodels.rb'
require './mysql-setup.rb'


get '/style.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :style
end

# index
get '/' do
  @posticon = { "GM" => "badge-star.png",
                "NPC" => "badge-star.png",
                "Adventurer" => "badge-solid.png" }

  def showifexists obj
    obj if obj
  end
  
  def gm? char
    char.user.id == char.adventure.user.id
  end
  
  @adventure = Adventure.first
  @characters = Character.all(:adventure => @adventure)
  @posts = Post.all :order => [:created_at.desc]
  
  haml :index
end

post '/' do
  adventure = Adventure.first
  author = Character.get( params[:author] )
  
  post = Post.new(
    :text => params[:text],
    :character => author,
    :adventure => adventure,
    :created_at => Time.now
  )
  if params[:ooc] != ""
    post.ooc = params[:ooc]
  end
  post.save
  redirect '/'
end

# register
get '/register/' do
  haml :register
end

# reset the database
get '/reset/' do
  DataMapper.auto_migrate!

  # fill up the database with some junk
  
  # users
  lurker = User.create(:name => "Lurker", :pass => "nil", :email => "nil", :verified => false)
  ethan = User.create(:name => "Ethan", :pass => "test", :email => "epemble@gmail.com", :verified => true)
  alex = User.create(:name => "Alex", :pass => "test", :email => "dickpemble@gmail.com", :verified => true)
  neil = User.create(:name => "Neil", :pass => "test", :email => "neil@neil.neil", :verified => true)

  # adventure
  adventure = Adventure.new(
    :name => "Demonstration",
    :created_on => Time.now,
    :description => "This is a demo adventure.",
    :user => alex
  )
  adventure.save
  
  # characters
  firebeard = Adventurer.create(
    :name => "Firebeard",
    :race => "Dwarf",
    :class => "Fighter",
    :visible => true,
    :user => ethan,
    :adventure => adventure
  )
  sheet = Sheet.create(:character => firebeard)

  shadow = Adventurer.create(
    :name => "Shadow",
    :race => "Halfling",
    :class => "Rogue",
    :visible => true,
    :user => neil,
    :adventure => adventure
  )
  
  npc = NPC.create(
    :name => "Druid Elder",
    :visible => true,
    :user => alex,
    :adventure => adventure
  )
  
  gm = GM.create(
    :name => "Game Master",
    :visible => true,
    :user => alex,
    :adventure => adventure
  )

  
  # posts
  post3 = Post.create(
    :text => "Shadow walks into the shadows.",
    :character => shadow, :adventure => adventure, :created_at => Time.now+2 )
  post2 = Post.create(
    :text => "Firebeard hates his stupid axe.  He roars a bunch.",
    :character => firebeard, :adventure => adventure, :created_at => Time.now+1 )
  post1 = Post.create(
    :text => "Welcome to the game.",
    :character => gm, :adventure => adventure, :created_at => Time.now )
  
  #
  redirect '/'
end

# delete
#get '/:id/delete' do
#  post=Post.get( params[:id] ).destroy
#  redirect '/'
#end
