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
end

# Create action - new show - redirects to that
# show

post "/shows" do
end

# Individual show page
# Links to list of all songs `/shows/:id/songs`
# and form to create new songs `/shows/:id/songs/new`

get "/shows/:id" do
end

# Form to create new songs

get "/shows/:id/songs/new" do
end

# Create action - new songs for a show - redirects
# to that song

post "/shows/:id/songs" do
end

# Lists all songs from the show

get "/shows/:id/songs" do
end

# Shows just one song from the show

get "/shows/:show_id/songs/:song_id" do
end