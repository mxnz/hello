require 'rails_helper'

RSpec.describe Order, type: :model do

  it { should belong_to :user }
  it { should belong_to :product }

  it { should validate_presence_of :user }
  it { should validate_presence_of :product }
  it { should validate_presence_of :url }
  it { should validate_presence_of :thumbnail_url }

  it { should have_db_column(:user_id).with_options(null: false) }
  it { should have_db_column(:product_id).with_options(null: false) }
  it { should have_db_column(:url).with_options(null: false) }
  it { should have_db_column(:thumbnail_url).with_options(null: false) }

  it { should have_db_index :user_id }
  it { should have_db_index :product_id }
end
