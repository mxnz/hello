require 'rails_helper'

RSpec.feature 'Visit product show page' do
  given(:guest) { create(:guest) }
  given(:owner) { create(:owner) }
  given(:admin) { create(:admin) }
  given(:product) { create(:product) }

  scenario 'Unauthorized user visits product show page' do
    visit product_path(product)
    expect(page).to_not have_content(product.store)
  end

  
  scenario 'Guest visits product show page' do
    sign_in guest
    visit product_path(product)
    expect(page).to_not have_content(product.store)
  end


  scenario 'Store owner visits product show page' do
    sign_in owner
    visit product_path(product)
    expect(page).to have_content(product.store)
  end

  scenario 'Admin visits product show page' do
    sign_in admin
    visit product_path(product)
    expect(page).to have_content(product.store)
  end
end
