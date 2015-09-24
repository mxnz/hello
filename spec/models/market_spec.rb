require 'rails_helper'

RSpec.describe Market, type: :model, skip: true do
  let(:market) { Market.new(photos_url: 'http://jsonplaceholder.typicode.com/photos',
                            todos_url:  'http://jsonplaceholder.typicode.com/todos') }

  describe '#get_photo' do
    it 'returns photo' do
      photo = market.get_photo

      expect(photo.album_id).to       be_present
      expect(photo.id).to             be_present
      expect(photo.title).to          be_present
      expect(photo.url).to            be_present
      expect(photo.thumbnail_url).to  be_present
    end
  end

  describe '#create_todo' do
    it 'returns created todo id' do
      todo_id = market.create_todo

      expect(todo_id).to         be_present
      expect(todo_id.class).to   eq Fixnum
    end
  end
end
