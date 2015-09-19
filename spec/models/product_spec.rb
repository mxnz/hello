require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should respond_to :name, :description, :photo }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_db_column(:name).with_options(null: false) }
  it { should have_db_index(:name).unique(true) }

  describe '#photo' do
    let(:product) { build(:product) }
    it 'should be a PhotoUploader' do
      expect(product.photo.class).to eq PhotoUploader
    end
  end
end
