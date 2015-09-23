require 'rails_helper'

RSpec.shared_examples "a user who can view all products" do
  it "<<" do
    sign_in user
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
