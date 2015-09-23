require 'rails_helper'

RSpec.feature 'Visit product index' do
  let!(:products) { create_list(:product, 3) }
  let!(:pro_product) { create(:product, pro: true) }

  scenario 'Unauthorized user visits product index and sees all products except pro' do
    visit products_path

    expect(page).to have_selector('h1', text: 'Products')

    products.each do |product|
      expect(page).to have_content product.name
      expect(page).to have_css("img[src=\"#{product.photo.url}\"]")
      expect(page).to have_css("a[href=\"#{product_path(product)}\"]")
    end

    expect(page).to_not have_content pro_product.name
  end

  scenario 'Guest visits product index page and sees all products' do
    sign_in(create(:guest))
    visit products_path

    expect(page).to have_selector('h1', text: 'Products')

    products.each do |product|
      expect(page).to have_content product.name
      expect(page).to have_css("img[src=\"#{product.photo.url}\"]")
      expect(page).to have_css("a[href=\"#{product_path(product)}\"]")
    end

    expect(page).to have_content pro_product.name
    expect(page).to have_css("img[src=\"#{pro_product.photo.url}\"]")
    expect(page).to have_css("a[href=\"#{product_path(pro_product)}\"]")
  end
end
