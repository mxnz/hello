require 'rails_helper'

RSpec.feature 'Edit product', type: :feature do

  given(:product) { create(:product) }
  before { sign_in(create(:user)) }

  scenario 'User can visit edit product page from show product page' do
    visit product_path(product)
    click_on 'Edit product'

    expect(current_path).to eq edit_product_path(product)
  end

  scenario 'User edits the product with valid data' do
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

  scenario 'User tries to edit the product with invalid data' do
    visit edit_product_path(product)
    fill_in 'Name', with: ''
    click_on 'Save'

    expect(page).to have_content "Name can't be blank"

    expect(page).to have_field 'Name'
    expect(page).to have_field 'Description'
    expect(page).to have_field 'Photo', type: 'file'
    expect(page).to have_button 'Save'  
  end

  scenario 'User removes photo from the product' do
    visit edit_product_path(product)
    check 'Remove photo'
    click_on 'Save'

    expect(page).to have_css("img[src=\"\"]")
  end

  scenario 'User removes product' do
    visit product_path(product)
    click_on 'Remove product'

    expect(current_path).to eq products_path
    expect(page).to_not have_content product.name
  end

  scenario 'Guest cannot remove product' do
    log_out
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Remove product')
  end

  scenario 'Guest cannot visit edit produt page from show product page' do
    log_out
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'Edit product')
  end

  it_behaves_like 'a page required authentication' do
    let(:path_to_page) { edit_product_path(product) } 
  end
end
