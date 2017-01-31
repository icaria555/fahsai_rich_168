class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :purchaser_id
      t.integer :saler_id
      t.float :total_price
      t.float :total_pv
      t.timestamps
    end
  end
end
