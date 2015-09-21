require 'rails_helper'

RSpec.describe Owner do
  it_behaves_like 'a user' do
    let(:user) { build(:owner) }
  end

  it { should validate_presence_of(:store) }
  it { should validate_length_of(:password).is_at_least(8) }
  it { should validate_presence_of(:avatar) }
end
