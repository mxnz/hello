require 'rails_helper'

RSpec.describe Admin do
  it_behaves_like 'a user'

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:avatar) }
  it { should validate_presence_of(:passport_photo) }
  it { should validate_presence_of(:birthdate) }
  it { should validate_length_of(:password).is_at_least(10) }
end
