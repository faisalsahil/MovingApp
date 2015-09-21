class CreateCustomersUsers < ActiveRecord::Migration
  def change
    create_table :customers_users do |t|
      t.integer :user_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
