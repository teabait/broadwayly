require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'active_record'
require_relative './models/shows'
require_relative './models/songs'

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  host: "localhost",
  username: "T-Virus",
  password: "",
  database: "broadway"
)

after do
  ActiveRecord::Base.clear_active_connections!
end

# Welcome to Broadway.ly!

get "/" do
  erb :index
end

# Index of all shows
# with links to individual shows

get "/shows" do
  @shows = Show.all
  erb :'shows/index'
end

# Form to create new show

get "/shows/new" do
  erb :'shows/new'
end

# Create action - new show - redirects to that
# show

post "/shows" do
  #create instance
  show = Show.new(title: params[:title], composer: params[:composer], img_url: params[:img_url])
  
  # save instance
  show.save

  # redirect to show page
  redirect "/#{show.id}"
end

# Individual show page
# Links to list of all songs `/shows/:id/songs`
# and form to create new songs `/shows/:id/songs/new`

get "/shows/:id" do
  @show = Show.find_by(id: params[:id])
  @songs_array = @show.songs
  erb :'shows/show'
end

# Form to create new songs

get "/shows/:id/songs/new" do
  erb :'songs/new'
end

# Create action - new songs for a show - redirects
# to that song

post "/shows/:id/songs" do
  # get just the embed_url
  @new_embed = params[:embed_url].slice! "http://www.youtube.com/watch?v=" 
  
  # create instance
  song = Song.new(title: params[:title], embed_url: new_embed)

  # get show to save song to show
  show = Show.find_by(id: params[:id])
  show.songs << song
  # save instance
  song.save

  # redirect to show page
  redirect "/#{show.id}"
end

# Lists all songs from the show

get "/shows/:id/songs" do
  @show = Show.find_by(id: params[:id])
  @songs_array = @show.songs
  erb :'songs/index'
end

# Shows just one song from the show

get "/shows/:show_id/songs/:song_id" do
  @song = Song.find_by(id: params[:song_id])
  erb :'songs/show'
end