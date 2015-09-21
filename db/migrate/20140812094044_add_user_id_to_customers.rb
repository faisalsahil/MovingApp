class AddUserIdToCustomers < ActiveRecord::Migration
  def change
  	add_column :customers,:user_id,:integer
  	add_column :customers,:creator_id,:integer
  end
end
