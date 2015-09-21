class AddCnFiedToItems < ActiveRecord::Migration
  def change
  	add_column :items, :cn, :boolean, :default=>false
  end
end
