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

  describe '#avatar' do
    it 'should be an AvatarUploader' do
      expect(user.avatar.class).to eq AvatarUploader
    end
  end

  describe '#passport_photo' do
    it 'should be a PassportPhotoUploader' do
      expect(user.passport_photo.class).to eq PassportPhotoUploader
    end
  end
end
