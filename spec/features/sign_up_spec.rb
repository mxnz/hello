require 'rails_helper'

RSpec.feature 'Sign up' do
  given(:user) { build(:user) } 

  scenario 'Guest signs up with valid credentials' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to_not have_selector(:link_or_button, 'Sign up')
    expect(current_path).to eq root_path
  end

  scenario 'Guest signs up with invalid credentials' do
    visit root_path
    click_on 'Sign up'
    click_on 'Sign up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(current_path).to eq user_registration_path
  end
end
