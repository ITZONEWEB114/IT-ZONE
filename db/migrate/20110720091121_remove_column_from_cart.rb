class RemoveColumnFromCart < ActiveRecord::Migration
  def self.up
    remove_column :carts, :amount
  end

  def self.down
    add_column :carts, :amount, :integer
  end
end
