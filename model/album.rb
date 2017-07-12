require('pg')
require_relative('./artist')
require_relative('../db/sql_runner')

class Album

attr_accessor (:
attr_reader

def initialize(options)
  @name = options["name"]
  @genre = options["genre"]
  @artist_id = options["artist_id"].to_i
end

def save
sql = "INSERT INTO album (name, genre) VALUES ('#{name}', '#{genre}') RETURNING id;"
result = SqlRunner.run(sql)
@id = result[0]['id'].to_i
end 

def self.all
 sql = "SELECT * FROM album;"
 result = SqlRunner.run(sql)
 return result.map {|album| Artist.new(album)}
end  

def artist
 sql = "SELECT * FROM artist WHERE id = #{@artist_id};"
 result = SqlRunner.run(sql)
 return result.map {|album| Album.new(album)}
end 


end 
