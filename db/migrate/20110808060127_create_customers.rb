class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name
      t.string :hash_password
      t.string :salt
      t.string :email
      t.string :active_code
      t.boolean :is_activated

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
