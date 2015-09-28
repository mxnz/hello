require 'rails_helper'

RSpec.feature 'Create order' do
  let(:guest) { create(:guest, email: 'aaa@bbb.cc') }
  let(:owner) { create(:owner) }
  let(:admin) { create(:admin) }
  let(:product) { create(:product) }
  let(:photo) { build(:photo) }
  let(:todo_id) { 8539 }

  before { Rails.configuration.market.set_photo(build(:photo)).set_todo_id(todo_id) }

  describe 'new order page' do
    it_behaves_like 'a page required authentication' do
      let(:path_to_page) { new_product_order_path(product) }
    end
  end

  scenario 'Store owner cannot visit new order page' do
    sign_in owner

    expect { visit new_product_order_path(product) }.to raise_error Pundit::NotAuthorizedError
  end

  scenario 'Store owner cannot view link to creating order on show product page' do
    sign_in owner
    visit product_path(product)

    expect(page).to_not have_link('Buy')
  end

  scenario 'Admin cannot visit new order page' do
    sign_in admin

    expect { visit new_product_order_path(product) }.to raise_error Pundit::NotAuthorizedError

  end

  scenario 'Admin cannot view link to creating order on show product page' do
    sign_in admin
    visit product_path(product)

    expect(page).to_not have_link('Buy')
  end

  scenario 'Guest views link to creating order on show product page' do
    sign_in guest
    visit product_path(product)

    expect(page).to have_link('Buy', new_product_order_path(product))
  end

  scenario 'Guest creates an order when his purchase is valid' do
    sign_in guest
    visit new_product_order_path(product)
    click_on 'Make an order'

    expect(current_path).to eq order_path(Order.last)
    expect(page).to have_content('Order was successfully created.')
  end

  scenario 'Guest cannot create an order when his purchase is not valid' do
    Rails.configuration.market.set_photo(build(:wrong_photo)).set_todo_id(todo_id)

    sign_in guest
    visit new_product_order_path(product)
    click_on 'Make an order'

    expect(current_path).to eq product_orders_path(product)
    expect(page).to have_content 'Wrong color!'
  end
end
