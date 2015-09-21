require 'rails_helper'

RSpec.shared_examples 'a user' do
  it { should respond_to :name,
                         :last_name,
                         :email,
                         :password,
                         :password_confirmation,
                         :avatar,
                         :passport_photo,
                         :birthdate,
                         :store,
                         :type
  }
  it { should have_db_column(:email).with_options(null: false) }
  it { should have_db_index(:email).unique(true) }
  it { should validate_presence_of(:email) }
end
