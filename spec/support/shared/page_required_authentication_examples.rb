require 'rails_helper'

RSpec.shared_examples 'a page required authentication' do
  scenario '<<' do
    visit path_to_page
    
    log_out if page.has_link? 'Log out'
    visit path_to_page
    
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end
