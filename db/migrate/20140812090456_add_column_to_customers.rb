class AddColumnToCustomers < ActiveRecord::Migration
  def change
  	add_column :customers, :bill_of_laden, :string
  	add_column :customers, :name, :string
  	add_column :customers, :phone, :string
  	add_column :customers, :loading_address, :string
  	add_column :customers, :destination_address, :string
  	add_column :customers, :tag_lot_number, :string
  	add_column :customers, :tag_lot_color, :string
	add_column :customers, :agent_name, :string
	add_column :customers, :date_of_pickup, :date
	add_column :customers, :charges, :string  	
  end
end
