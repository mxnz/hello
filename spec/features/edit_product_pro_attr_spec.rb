require 'rails_helper'

RSpec.feature 'Edit product pro attribute' do
  given(:admin) { create(:admin) }
  given(:guest) { create(:guest) }
  given(:owner) { create(:owner) }
  given(:product) { create(:product) }
  given(:pro_product) { create(:product, pro: true) }
   

  scenario 'Admin marks product as pro' do
    sign_in admin
    visit product_path(product)
    click_on 'set PRO status'

    expect(page).to_not have_selector(:link_or_button, 'set PRO status')
    expect(page).to     have_selector(:link_or_button, 'cancel PRO status')
  end

  scenario 'Admin cancels pro status for a product' do
    sign_in admin
    visit product_path(pro_product)
    click_on 'cancel PRO status'

    expect(page).to     have_selector(:link_or_button, 'set PRO status')
    expect(page).to_not have_selector(:link_or_button, 'cancel PRO status')
  end

  scenario 'Guest cannot change pro status' do
    sign_in guest
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'set PRO status')
    expect(page).to_not have_selector(:link_or_button, 'cancel PRO status')
  end

  scenario 'Store owner cannot change pro status' do
    sign_in owner
    visit product_path(product)

    expect(page).to_not have_selector(:link_or_button, 'set PRO status')
    expect(page).to_not have_selector(:link_or_button, 'cancel PRO status')
  end
end
