class ChangeNameInUsers < ActiveRecord::Migration
  def up
    change_column :users, :name, :string, null: true
    remove_index :users, :name
  end

  def down
    change_column :users, :name, :string, null: false
    add_index :users, :name, unique: true
  end
end
