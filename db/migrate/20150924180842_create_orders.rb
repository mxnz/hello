class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :product, index: true, foreign_key: true, null: false
      t.string :url, null: false
      t.string :thumbnail_url, null: false

      t.timestamps null: false
    end
  end
end
