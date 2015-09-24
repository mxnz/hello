require 'net/http'

class Market
  attr_reader :photos_uri, :todos_uri
  Struct.new('Photo', :album_id, :id, :title, :url, :thumbnail_url)

  def initialize(options)
    @photos_uri = URI(options.fetch(:photos_url))
    @todos_uri = URI(options.fetch(:todos_url))
  end

  def get_photo
    photos = JSON.parse(Net::HTTP.get(photos_uri))
    photo = photos[rand(0...photos.length)]
    photo = Struct::Photo.new(
      photo['albumId'],
      photo['id'],
      photo['title'],
      photo['url'],
      photo['thumbnailUrl']
    )
  end

  def create_todo
    todo_id = JSON.parse(Net::HTTP.post_form(todos_uri, {}).body)['id']
  end
end
