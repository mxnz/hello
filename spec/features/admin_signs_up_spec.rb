require 'rails_helper'

RSpec.feature 'Admin signs up' do
  given(:admin) { build(:admin) } 

  scenario 'Admin signs up with valid credentials' do
    visit root_path
    click_on 'as an admin'
    fill_in 'Email', with: admin.email
    fill_in 'Name', with: admin.name
    fill_in 'Last name', with: admin.last_name
    attach_file 'Avatar', 'spec/support/rails.png'
    attach_file 'Passport photo', 'spec/support/ruby.jpeg'
    select '2000', from: 'admin_birthdate_1i'
    select 'January', from: 'admin_birthdate_2i'
    select '1', from: 'admin_birthdate_3i'
    fill_in 'Password', with: admin.password
    fill_in 'Password confirmation', with: admin.password
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to_not have_selector(:link_or_button, 'Sign up')
    expect(current_path).to eq root_path
  end

  scenario 'Admin signs up with invalid credentials' do
    visit root_path
    click_on 'as an admin'
    click_on 'Sign up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Avatar can't be blank")
    expect(page).to have_content("Passport photo can't be blank")
    expect(page).to have_content("Birthdate can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(current_path).to eq admin_registration_path
  end

  scenario 'Admin tries to enter too short password' do
    visit root_path
    click_on 'as an admin'
    fill_in 'Email', with: admin.email
    fill_in 'Name', with: admin.name
    fill_in 'Last name', with: admin.last_name
    attach_file 'Avatar', 'spec/support/rails.png'
    attach_file 'Passport photo', 'spec/support/ruby.jpeg'
    select '2000', from: 'admin_birthdate_1i'
    select 'January', from: 'admin_birthdate_2i'
    select '1', from: 'admin_birthdate_3i'

    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content("Password is too short")
    expect(current_path).to eq admin_registration_path
  end

  scenario 'Admin enters password with minimal length' do
    visit root_path
    click_on 'as an admin'
    fill_in 'Email', with: admin.email
    fill_in 'Name', with: admin.name
    fill_in 'Last name', with: admin.last_name
    attach_file 'Avatar', 'spec/support/rails.png'
    attach_file 'Passport photo', 'spec/support/ruby.jpeg'
    select '2000', from: 'admin_birthdate_1i'
    select 'January', from: 'admin_birthdate_2i'
    select '1', from: 'admin_birthdate_3i'

    fill_in 'Password', with: '1234567890'
    fill_in 'Password confirmation', with: '1234567890'
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to_not have_selector(:link_or_button, 'Sign up')
    expect(current_path).to eq root_path
  end
end
