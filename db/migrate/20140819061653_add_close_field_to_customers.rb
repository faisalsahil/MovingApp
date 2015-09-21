class AddCloseFieldToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :close, :boolean, :default=> false
    add_column :customers, :close_date, :datetime
  end
end
