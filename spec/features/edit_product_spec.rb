require 'rails_helper'

RSpec.feature 'Edit product', type: :feature do

  given(:product) { create(:product) }
  given(:owner) { create(:owner) }
  given(:guest) { create(:guest) }
  given(:admin) { create(:admin) }

  it_behaves_like 'a page required authentication' do
    let(:path_to_page) { edit_product_path(product) } 
  end

  scenario 'Store owner can visit edit product page from show product page' do
    sign_in owner
    visit product_path(product)
    click_on 'Edit product'

    expect(current_path).to eq edit_product_path(product)
  end

  scenario 'Store owner edits the product with valid data' do
    sign_in owner
    visit edit_product_path(product)

    fill_in 'Name', with: 'New name'
    fill_in 'Description', with: 'New description'
    attach_file 'Photo', 'spec/support/ruby.jpeg'
    click_on 'Save'

    expect(current_path).to eq product_path(product)
    expect(page).to have_selector 'h1', 'New name'
    expect(page).to have_content 'New description'
    expect(page).to have_css("img[src$=\"ruby.jpeg\"]")
  end

  scenario 'Store owner cannot edit the product with invalid data' do
    sign_in owner
    visit edit_product_path(product)
    fill_in 'Name', with: ''
    click_on 'Save'

    expect(page).to have_content "Name can't be blank"

    expect(page).to have_field 'Name'
    expect(page).to have_field 'Description'
    expect(page).to have_field 'Photo', type: 'file'
    expect(page).to have_button 'Save'  
  end

  scenario 'Store owner removes photo from the product' do
    sign_in owner
    visit edit_product_path(product)
    check 'Remove photo'
    click_on 'Save'

    expect(page).to have_css("img[src=\"\"]")
  end

  scenario 'Store owner removes product' do
    sign_in owner
    visit product_path(product)
    click_on 'Remove product'

    expect(current_path).to eq products_path
    expect(page).to_not have_content product.name
  end


  scenario 'Unauthorized user cannot remove product' do
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Remove product')
  end

  scenario 'Unauthorized user cannot visit edit product page from show product page' do
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Edit product')
  end

  scenario 'Unauthorized user cannot remove product page from show product page' do
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Remove product')
  end


  scenario 'Guest cannot remove product' do
    sign_in guest
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Remove product')
  end

  scenario 'Guest cannot visit edit product page from show product page' do
    sign_in guest
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Edit product')
  end

  scenario 'Guest cannot remove product from show product page' do
    sign_in guest
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Remove product')
  end

  scenario 'Guest cannot visit edit product page' do
    sign_in guest
    expect { visit edit_product_path(product) }.to raise_error Pundit::NotAuthorizedError
  end


  scenario 'Admin cannot remove product' do
    sign_in admin
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Remove product')
  end

  scenario 'Admin cannot visit edit product page from show product page' do
    sign_in admin
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Edit product')
  end

  scenario 'Admin cannot remove product from show product page' do
    sign_in admin
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Remove product')
  end

  scenario 'Admin cannot visit edit product page' do
    sign_in admin
    expect { visit edit_product_path(product) }.to raise_error Pundit::NotAuthorizedError
  end
end
