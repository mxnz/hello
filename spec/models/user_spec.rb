require 'rails_helper'

RSpec.describe User, type: :model do
  it { should respond_to :name, :email, :password, :password_confirmation }
  it { should have_db_column(:name).with_options(null: false) }
  it { should have_db_column(:email).with_options(null: false) }
  it { should have_db_index(:name).unique(true) }
  it { should have_db_index(:email).unique(true) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
