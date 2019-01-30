require('pg')

class Artist

attr_accessor :name, :id

  def initialize(details)
    @name = details['name']
    @id = details['id'].to_i if details['id']
  end

  def save
    db = PG.connect( {dbname: "music_collection", host: "localhost"})

    sql = "INSERT INTO artist(name) VALUES ($1)

    RETURNING id"
    values = [@name]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def Artist.list_all_artists
    db = PG.connect( {dbname: "music_collection", host: "localhost"})
    sql = "SELECT * FROM artist"
    db.prepare("list_all_artists", sql)
    results = db.exec_prepared("list_all_artists")
    db.close()
    return results.map { |artist| Artist.new(artist) }

  end

  def list_all_albums_by_artist
    db = PG.connect( {dbname: "music_collection", host: "localhost"})
    sql = "SELECT * FROM album WHERE artist_id = ($1)"
    values = [@id]
    db.prepare("list_all_albums_by_artist", sql)
    results = db.exec_prepared("list_all_albums_by_artist", values)
    db.close()
    return results.map { |album| Album.new(album) }

  end



end
