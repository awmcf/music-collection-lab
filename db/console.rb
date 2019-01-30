require_relative('../models/artist')
require_relative('../models/album')
require('pry')



artist_1 = Artist.new({
  'name' => 'Blink 182'
  })

artist_1.save()


artist_2 = Artist.new({
  'name' => 'Green Day'
  })

artist_2.save()

album_1 = Album.new({
  'title' => 'Take Off Your Pants and Jacket',
  'genre' => 'rock',
  'artist_id' => artist_1.id
  })

album_1.save()

  album_2 = Album.new({
    'title' => 'American Idiot',
    'genre' => 'punk',
    'artist_id' => artist_2.id
    })

album_2.save()

  album_3 = Album.new({
    'title' => 'Dookie',
    'genre' => 'punk',
    'artist_id' => artist_2.id
    })

    album_3.save()

artist_list = Artist.list_all_artists
album_list = Album.list_all_albums

green_day_albums = artist_2.list_all_albums_by_artist()


binding.pry
nil
