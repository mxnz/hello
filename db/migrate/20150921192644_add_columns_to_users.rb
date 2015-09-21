class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :avatar, :string
    add_column :users, :passport_photo, :string
    add_column :users, :birthdate, :date
    add_column :users, :store, :string
    add_column :users, :type, :string
  end
end
