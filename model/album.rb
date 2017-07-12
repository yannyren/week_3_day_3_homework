require('pg')
require_relative('./artist')
require_relative('../db/sql_runner')

class Album

  attr_reader :name, :genre, :artist_id


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

  def self.delete_all()
    sql = "DELETE FROM album"
    return SqlRunner.run(sql) 
  end 

  def update(artist)
    sql = "UPDATE album SET name = '#{artist.name}' WHERE id = #{artist.id};"
    return SqlRunner.run(sql)
  end 

  def delete(id)
    sql = "DELETE FROM album WHERE id = '#{@id}';"
    return SqlRunner.run(sql)
  end 

  def self.find(artist)
    sql = "SELECT * FROM album WHERE id = #{artist.id};"
    result = SqlRunner.run(sql)
    return Album.new(result[0])
  end 

end 
