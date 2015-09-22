require 'rails_helper'

RSpec.feature 'Store owner signs up' do
  given(:owner) { build(:owner) } 

  scenario 'Store owner signs up with valid credentials' do
    visit root_path
    click_on 'as a store owner'
    fill_in 'Email', with: owner.email
    fill_in 'Store', with: owner.store
    attach_file 'Avatar', 'spec/support/rails.png'
    fill_in 'Password', with: owner.password
    fill_in 'Password confirmation', with: owner.password
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to_not have_selector(:link_or_button, 'Sign up')
    expect(current_path).to eq root_path
  end

  scenario 'Store owner tries to enter too short password' do
    visit root_path
    click_on 'as a store owner'
    fill_in 'Email', with: owner.email
    fill_in 'Store', with: owner.store
    attach_file 'Avatar', 'spec/support/rails.png'
    fill_in 'Password', with: '1234567'
    fill_in 'Password confirmation', with: '1234567'
    click_on 'Sign up'

    expect(page).to have_content("Password is too short")
    expect(current_path).to eq owner_registration_path
  end

  scenario 'Store owner enters password with minimal length' do
    visit root_path
    click_on 'as a store owner'
    fill_in 'Email', with: owner.email
    fill_in 'Store', with: owner.store
    attach_file 'Avatar', 'spec/support/rails.png'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to_not have_selector(:link_or_button, 'Sign up')
    expect(current_path).to eq root_path
  end

  scenario 'Store owner signs up with invalid credentials' do
    visit root_path
    click_on 'as a store owner'
    click_on 'Sign up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Store can't be blank")
    expect(page).to have_content("Avatar can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(current_path).to eq owner_registration_path
  end
end
