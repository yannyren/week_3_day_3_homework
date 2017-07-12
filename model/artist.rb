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
  sql = "SELECT * FROM album WHERE id = #{@artist_id};"
  result = SqlRunner.run(sql)
  return result.map {|album| Album.new(album)}
 end 



end 