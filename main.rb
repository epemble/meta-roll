# main.rb
require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require './rollmodels.rb'
require './mysql-setup.rb'


# index
get '/' do
  @posticon = { "GM" => "badge-star.png",
                "NPC" => "badge-star.png",
                "Adventurer" => "badge-solid.png" }

  def showifexists obj
    obj if obj
  end
  
  def gm? char
    if char.user.id == char.adventure.user.id then true
    else false
    end
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

get '/reset' do
  DataMapper.auto_migrate!

  # fill up the database with some junk
  
  # users
  lurker = User.create(:name => "Lurker", :pass => "nil", :email => "nil", :verified => false)
  ethan = User.new(:name => "Ethan", :pass => "test", :email => "epemble@gmail.com", :verified => true)
  ethan.save
  alex = User.new(:name => "Alex", :pass => "test", :email => "dickpemble@gmail.com", :verified => true)
  alex.save

  # adventure
  adventure = Adventure.new(
    :name => "Demonstration",
    :created_on => Time.now,
    :description => "This is a demo adventure.",
    :user => alex
  )
  adventure.save
  
  # characters
  character = Adventurer.new(
    :name => "Firebeard",
    :race => "Dwarf",
    :class => "Fighter",
    :visible => true,
    :user => ethan,
    :adventure => adventure
  )
  character.save
  sheet = Sheet.create(:character => character)

  npc = NPC.new(
    :name => "Shadow",
    :visible => true,
    :user => alex,
    :adventure => adventure
  )
  npc.save
  
  gm = GM.create(
    :name => "Game Master",
    :visible => true,
    :user => alex,
    :adventure => adventure
  )

  
  # posts
  post3 = Post.create(
    :text => "Shadow walks into the shadows.",
    :character => npc, :adventure => adventure, :created_at => Time.now+2 )
  post2 = Post.create(
    :text => "Firebeard hates his stupid axe.  He roars a bunch.",
    :character => character, :adventure => adventure, :created_at => Time.now+1 )
  post1 = Post.create(
    :text => "Welcome to the game.",
    :character => gm, :adventure => adventure, :created_at => Time.now )
  
  #
  redirect '/'
end

# create
#post '/' do
#  post = Post.create( :title => params[:title], :created_at => Time.now )
#  redirect '/'
#end

# mark complete / incomplete
#get '/:id/mark/:is_complete' do
#  post=Post.get( params[:id] )
#  post.update( :complete => ( params[:is_complete] == 'complete' ) )
#  redirect '/'
#end

# delete
#get '/:id/delete' do
#  post=Post.get( params[:id] ).destroy
#  redirect '/'
#end