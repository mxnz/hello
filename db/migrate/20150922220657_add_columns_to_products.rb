class AddColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pro, :boolean, null: false, default: false
    add_column :products, :store, :string, null: false
  end
end
