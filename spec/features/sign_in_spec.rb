RSpec.feature 'Sign in', type: :feature, focus: true do
 
  scenario 'User sign in' do
    sign_in(create(:user))

    expect(page).to have_content 'Signed in successfully'
    expect(page).to_not have_selector(:link_or_button, 'Log in')
    expect(page).to have_selector(:link_or_button, 'Log out')
    expect(current_path).to eq root_path
  end

  scenario 'A non-registered user cannot sign in' do
    sign_in(build(:user))

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
