require('pry-byebug')
require_relative('../model/album')
require_relative('../model/artist')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new(
  {"name" => "Andy"})
artist1.save

album1 = Album.new(
  {"name" => "Bad Pizza",
    "genre" => "classical",
    "artist_id" => artist1.id})
album1.save

Album.all
Artist.all

album1.artist
artist1.album

album1.update(artist1)
artist1.update(artist1)

Album.find(artist1)

binding.pry

nil