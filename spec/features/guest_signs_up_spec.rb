require 'rails_helper'

RSpec.feature 'Guest signs up' do
  given(:guest) { build(:guest) } 

  scenario 'Guest signs up with valid credentials' do
    visit root_path
    click_on 'as a guest'
    fill_in 'Email', with: guest.email
    fill_in 'Password', with: guest.password
    fill_in 'Password confirmation', with: guest.password
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to_not have_selector(:link_or_button, 'Sign up')
    expect(current_path).to eq root_path
  end

  scenario 'Guest signs up with invalid credentials' do
    visit root_path
    click_on 'as a guest'
    click_on 'Sign up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(current_path).to eq guest_registration_path
  end

  scenario 'Guest tries to enter too short password' do
    visit root_path
    click_on 'as a guest'
    fill_in 'Email', with: guest.email
    fill_in 'Password', with: '12345'
    fill_in 'Password confirmation', with: '12345'
    click_on 'Sign up'

    expect(page).to have_content("Password is too short")
    expect(current_path).to eq guest_registration_path
  end

  scenario 'Guest enters password with minimal length' do
    visit root_path
    click_on 'as a guest'
    fill_in 'Email', with: guest.email
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to_not have_selector(:link_or_button, 'Sign up')
    expect(current_path).to eq root_path
  end
end
