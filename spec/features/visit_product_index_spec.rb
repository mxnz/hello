require 'rails_helper'

RSpec.feature 'Visit product index' do
  let!(:products) { create_list(:product, 3) }

  scenario 'User visits product index' do
    visit products_path

    expect(page).to have_selector('h1', text: 'Products')

    products.each do |product|
      expect(page).to have_selector('h2', text: product.name)
      expect(page).to have_css("img[src=\"#{product.photo.url}\"]")
      expect(page).to have_css("a[href=\"#{product_path(product)}\"]")
    end
  end
end
