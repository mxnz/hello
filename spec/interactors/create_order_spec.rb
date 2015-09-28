require 'rails_helper'

RSpec.describe CreateOrder, type: :interactor do
  describe '.call' do
    let!(:admins) { create_list(:admin, 2) }
    let(:guest) { create(:guest) }
    let(:todo_id) { 3892 }
    let(:product) { create(:product) }
    let(:create_order) { CreateOrder.(product: product, guest: guest) }

    context 'on successful purchase' do
      let(:photo) { build(:photo) }
      before { Rails.configuration.market.set_photo(photo).set_todo_id(todo_id) }

      it 'return context with success value' do
        expect(create_order).to be_success
      end

      it 'creates order with given product, guest and photo urls' do
        order = create_order.order
        expect(order).to be_persisted
        expect(order.product).to eq product
        expect(order.user).to eq guest
        expect(order.url).to eq photo[:url]
        expect(order.thumbnail_url).to eq photo[:thumbnail_url]
      end

      it 'sends email to guest with link to photo' do
        create_order
        open_email(guest.email)
        expect(current_email).to have_link photo[:title], photo[:url]
      end

      it 'sends email to all admins with todo id' do
        create_order
        Admin.all.each do |admin|
          open_email(admin.email)
          expect(current_email).to have_content todo_id
        end
      end
    end

    context 'on error purchase' do
      let(:wrong_photo) { build(:wrong_photo) }
      before { Rails.configuration.market.set_photo(wrong_photo).set_todo_id(todo_id) }

      it "return failed status" do
        expect(create_order).to_not be_success
      end

      it 'returns error message' do
        expect(create_order.message).to_not be_empty
      end

      it "doesn't create order" do
        expect { create_order }.to_not change(Order, :count)
      end

      it "sends email with guest's email to add admins" do
        create_order
        Admin.all.each do |admin|
          open_email(admin.email)
          expect(current_email).to have_content(guest.email) 
        end
      end
    end
  end
end
