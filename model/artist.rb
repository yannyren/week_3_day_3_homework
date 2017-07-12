require('pg')
require_relative('./album')
require_relative('../db/sql_runner')


class Artist

  attr_reader :id, :name

  def initialize(options)
    @name = options["name"]
    @id = options["id"].to_i  
  end 
 
  def save
  sql = "INSERT INTO artist (name) VALUES ('#{name}') RETURNING id;"
  result = SqlRunner.run(sql)
  @id = result[0]['id'].to_i
  end 

 def self.all
  sql = "SELECT * FROM artist;"
  result = SqlRunner.run(sql)
  return result.map {|artist| Artist.new(artist)}
 end  

 def album
  sql = "SELECT * FROM album WHERE artist_id = #{@id};"
  result = SqlRunner.run(sql)
  return result.map {|album| Album.new(album)}
 end 


 def self.delete_all()
   sql = "DELETE FROM artist"
   return SqlRunner.run(sql) 
 end 

 def update(artist)
   sql = "UPDATE artist SET name = '#{artist.name}' WHERE id = #{artist.id}"
   return SqlRunner.run(sql)
 end

 # def update(artist)
 #   sql = "UPDATE album SET name = '#{artist.name}' WHERE id = #{artist.id};"
 #   return SqlRunner.run(sql)
 # end 

def delete(id)
  sql = "DELETE FROM artist WHERE id = '#{@id}'"
  return SqlRunner.run(sql)
end 

def self.find(id)
  sql = "SELECT * FROM artist WHERE id = #{id};"
  result = SqlRunner.run(sql)
  return Artist.new(result[0])
end 

end 