class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_number
      t.string :description_at_origin
      t.string :driver
      t.string :warehouse
      t.string :warehouse_cross
      t.string :shipper
      t.string :desr_symbole
      t.string :exception_symbol
      t.string :location_symbol
      t.string :file1
      t.string :file2
      t.string :exception
      t.integer :customer_id

      t.timestamps
    end
  end
end
