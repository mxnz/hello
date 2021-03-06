require 'net/http'

class Market
  attr_reader :photos_uri, :todos_uri

  def initialize(options)
    @photos_uri = URI(options.fetch(:photos_url))
    @todos_uri = URI(options.fetch(:todos_url))
  end

  def get_photo
    random_lag
    photos = JSON.parse(Net::HTTP.get(photos_uri))
    photo = photos[rand(0...photos.length)]
    {
      album_id:       photo['albumId'],
      id:             photo['id'],
      title:          photo['title'],
      url:            photo['url'],
      thumbnail_url:  photo['thumbnailUrl']
    }
  end

  def create_todo
    random_lag
    todo_id = JSON.parse(Net::HTTP.post_form(todos_uri, {}).body)['id']
  end


  private

    def random_lag
      sleep(rand 0..6)
    end
end
