require 'rails_helper'

RSpec.feature 'Create product', type: :feature do
  given(:product) { Product.last }
  given(:guest) { create(:guest) }
  given(:owner) { create(:owner) }
  given(:admin) { create(:admin) }

  it_behaves_like 'a page required authentication' do
    let(:path_to_page) { new_product_path }
  end

  scenario 'A store owner adds a new product with valid data' do
    sign_in owner
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

  scenario 'A store owner tries to add a new product with invalid data' do
    sign_in owner
    visit new_product_path
    click_on 'Save'

    expect(page).to have_content "Name can't be blank"

    expect(page).to have_field 'Name'
    expect(page).to have_field 'Description'
    expect(page).to have_field 'Photo', type: 'file'
    expect(page).to have_button 'Save'
  end


  scenario 'Unauthorized user cannot view "Add new product" link on product index page' do
    visit products_path

    expect(page).to_not have_selector(:link_or_button, 'Add new product')
  end


  scenario 'A guest cannot view "Add new product" link on product index page' do
    sign_in guest
    visit products_path
    
    expect(page).to_not have_selector(:link_or_button, 'Add new product')
  end

  scenario 'A guest cannot add a new product' do
    sign_in guest
    expect { visit new_product_path }.to raise_error Pundit::NotAuthorizedError
  end


  scenario 'An admin cannot view "Add new product" link on product index page' do
    sign_in admin
    visit products_path
    
    expect(page).to_not have_selector(:link_or_button, 'Add new product')
  end

  scenario 'An admin cannot add a new product' do
    sign_in admin
    expect { visit new_product_path }.to raise_error Pundit::NotAuthorizedError
  end
end
