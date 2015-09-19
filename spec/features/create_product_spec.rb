require 'rails_helper'

RSpec.feature 'Create product', type: :feature do
  given(:product) { Product.last }

  scenario 'User adds a new product with valid data' do
    visit new_product_path

    fill_in 'Name', with: 'MegaSuperProduct'
    fill_in 'Description', with: 'It is a very good product'
    attach_file 'Photo', 'spec/support/rails.png'
    click_on 'Save'

    expect(current_path).to eq product_path(product)
    expect(page).to have_selector 'h1', 'MegaSuperProduct'
    expect(page).to have_content 'It is a very good product'
    expect(page).to have_css("img[src=\"#{product.photo.url}\"]")
  end

  scenario 'User tries to add a new product with invalid data' do
    visit new_product_path
    click_on 'Save'

    expect(page).to have_content "Name can't be blank"

    expect(page).to have_field 'Name'
    expect(page).to have_field 'Description'
    expect(page).to have_field 'Photo', type: 'file'
    expect(page).to have_button 'Save'
  end
end
