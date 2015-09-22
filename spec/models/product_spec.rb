require 'rails_helper'

RSpec.describe Product, type: :model do
  before { create(:product) }

  it { should respond_to :name, :description, :photo, :pro?, :store }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_db_column(:name).with_options(null: false) }
  it { should have_db_index(:name).unique(true) }
  it { should have_db_column(:pro).with_options(null: false, default: false) }
  it { should have_db_column(:store).with_options(null: false) }
  it { should validate_presence_of(:store) }

  describe '#photo' do
    let(:product) { build(:product) }
    it 'should be a PhotoUploader' do
      expect(product.photo.class).to eq PhotoUploader
    end
  end
end
