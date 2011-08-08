class AddColumnToCart < ActiveRecord::Migration
  def self.up
    add_column :carts, :amount, :integer
  end

  def self.down
    remove_column :carts, :amount
  end
end
