require 'rails_helper'

RSpec.describe TestMarket, type: :model do
  let(:test_market) { TestMarket.new }

  describe '#set_photo' do
    let(:photo) { create(:photo) }
    before { test_market.set_photo(photo) }

    it 'should set photo to return' do
      got_photo = test_market.get_photo

      expect(got_photo.object_id).to_not    eq photo[:object_id]
      expect(got_photo[:album_id]).to       eq photo[:album_id]
      expect(got_photo[:id]).to             eq photo[:id]
      expect(got_photo[:title]).to          eq photo[:title]
      expect(got_photo[:url]).to            eq photo[:url]
      expect(got_photo[:thumbnail_url]).to  eq photo[:thumbnail_url]
    end
  end

  describe '#set_todo_id' do
    let(:todo_id) { 100 }
    before { test_market.set_todo_id(todo_id) }

    it 'set todo id to return on todo creating' do
      expect(test_market.create_todo).to eq todo_id
    end
  end
end
