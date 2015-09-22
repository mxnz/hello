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
end
