require('pg')

class Album

attr_accessor :title, :genre, :artist_id, :id

  def initialize(details)
    @title = details['title']
    @genre = details['genre']
    @artist_id = details['artist_id']
    @id = details['id'].to_i if details['id']
  end

  def save
    db = PG.connect( {dbname: "music_collection", host: "localhost"})
    sql = "INSERT INTO album(title, genre, artist_id) VALUES ($1, $2, $3)

    RETURNING id"
    values = [@title, @genre, @artist_id]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def Album.list_all_albums
    db = PG.connect( {dbname: "music_collection", host: "localhost"})
    sql = "SELECT * FROM album"
    db.prepare("list_all_albums", sql)
    results = db.exec_prepared("list_all_albums")
    db.close()
    return results.map { |album| Album.new(album) }
  end

  def list_artist_by_album
    db = PG.connect( {dbname: "music_collection", host: "localhost"})
    sql = "SELECT * FROM artist WHERE artist_id = ($1)"
    values = [@artist_id]
    db.prepare("list_all_albums_by_artist", sql)
    results = db.exec_prepared("list_all_albums_by_artist", values)
    db.close()
    return results.map { |album| Album.new(album) }

  end



end
