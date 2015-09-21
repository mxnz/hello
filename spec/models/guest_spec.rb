require 'rails_helper'

RSpec.describe Guest, type: :model do
  it_behaves_like 'a user' do
    let(:user) { build(:guest) }
  end

  it { should validate_length_of(:password).is_at_least(8) }
end
